import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/user_model.dart';
import '../data/providers/user_provider.dart';
import '../data/static_data.dart';
import '../helpers/dialog_widget.dart';

class UserAuthController extends GetxController with StateMixin<User>{
  //TODO: Implement UserAuthController

  static var userAuth = GetStorage();

  @override
  void onInit(){
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  void responseStatusError(data, message, status){
    change(data, status: status);
    dialogError(message);
  }

  void registerUser(String name, String email, String password) {
    if (name == '') {
      dialogError("name field required");
    } else if (email == '') {
      dialogError("email field required");
    } else if (password == '') {
      dialogError("password field required");
    } else {
      change(null, status: RxStatus.loading());
      UserProvider().registerUser(name, password, email).then((response) {
        print(response.body);
        if(response.statusCode == 400){
          Map<String, dynamic> errors = response.body['data']['errors'];
          errors.forEach((field, messages) {
            String errorMessage = messages[0];
            responseStatusError(null, errorMessage, RxStatus.error());
          });
        } else if(response.statusCode == 500){
          change(null, status: RxStatus.error());
          dialogError('Sorry, Internal Server Error!');
        } else if(response.statusCode == 200){
          try{
            var data = User.fromJson(response.body['data']['user']);
            data.token = response.body['data']['token_type']+ ' ' + response.body['data']['access_token'];
            print(data.toJson());
            change(data, status: RxStatus.success());
            Get.toNamed('/verify', arguments: data.token);
          }catch(e){
            responseStatusError(null, e.toString(), RxStatus.error());
          }
        }else{
          change(null, status: RxStatus.error());
        }
      }, onError: (e) {
        responseStatusError(null, e.toString(), RxStatus.error());
      });
    }
  }

  void registerAgent(String name, String email, String password, String file) {
    if (name == '') {
      dialogError("name field required");
    } else if (email == '') {
      dialogError("email field required");
    } else if (password == '') {
      dialogError("password field required");
    } else if (file == '' ) {
      dialogError("File field required");
    } else {
      change(null, status: RxStatus.loading());
      try{
        UserProvider().registerAgent(name, password, email, File(file)).then((response) {
          print(response.body);
          if(response.statusCode == 400){
            Map<String, dynamic> errors = response.body['data']['errors'];
            errors.forEach((field, messages) {
              String errorMessage = messages[0];
              responseStatusError(null, errorMessage, RxStatus.error());
            });
          } else if(response.statusCode == 500){
            change(null, status: RxStatus.error());
            dialogError('Sorry, Internal Server Error!');
          } else if(response.statusCode == 200){
            try{
              var data = User.fromJson(response.body['data']['user']);
              data.token = response.body['data']['token_type']+ ' ' + response.body['data']['access_token'];
              print(data.toJson());
              change(data, status: RxStatus.success());
              Get.toNamed('/verify', arguments: data.token);
            }catch(e){
              change(null, status: RxStatus.error());
            }
          }
        }, onError: (e) {
          responseStatusError(null, e.toString(), RxStatus.error());
        });
      }catch(e){
        print(e.toString());
        change(null, status: RxStatus.error());
      }
    }
  }

  void verify(String otp, String token) {
    if (otp == '') {
      dialogError("otp wrong");
    } else {
      print("status: $status");
      change(null, status: RxStatus.loading());
      UserProvider().verifyEmail(otp, token).then((response) {
        print(response.body);
        if(response.statusCode == 400){
          String errors = response.body['data']['errors'];
          responseStatusError(null, errors, RxStatus.error());

        } else if(response.statusCode == 500){
          change(null, status: RxStatus.error());
          dialogError('Sorry, Internal Server Error!');
        } else if(response.statusCode == 200){
          try{
            var data = User.fromJson(response.body['data']['user']);
            data.token = token;
            userAuth.write('user', data);
            print(data.toJson());
            change(data, status: RxStatus.success());
            Get.offAllNamed('/home');
          }catch(e){
            responseStatusError(null, e.toString(), RxStatus.error());
          }
        }
      }, onError: (e) {
        responseStatusError(null, e.toString(), RxStatus.error());
      });
    }
  }

  void login(String email, String password){
    if(email == ''){
      dialogError('email must be filled!');
    }else if(password == ''){
      dialogError('password must be filled!');
    }else{
      change(null, status: RxStatus.loading());
      try{

        UserProvider().login(email, password).then((response) {
          print(response.body);
          if(response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 404){
            String errors = response.body['data']['errors'];
            responseStatusError(null, errors, RxStatus.error());

          } else if(response.statusCode == 500){
            change(null, status: RxStatus.error());
            dialogError('Sorry, Internal Server Error!');
          } else if(response.statusCode == 200){
            try{
              var data = User.fromJson(response.body['data']['user']);
              data.token = response.body['data']['token_type']+ ' ' + response.body['data']['access_token'];
              userAuth.write('user', data);
              print("read storage ${userAuth.read('user')}");
              print(data.toJson());
              change(data, status: RxStatus.success());
              Get.offAllNamed('/home');
            }catch(e){
              print(e.toString());
              responseStatusError(null, e.toString(), RxStatus.error());
            }}else{}
        });
      }catch(e){
        responseStatusError(null, e.toString(), RxStatus.error());
      }
    }
  }

  void getAllUsers(){
      change(null, status: RxStatus.loading());
      try{
        UserProvider().getAllUsers().then((response) {
          print(response.body);
          if(response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 404){
            String errors = response.body['data']['errors'];
            responseStatusError(null, errors, RxStatus.error());

          } else if(response.statusCode == 500){
            change(null, status: RxStatus.error());
            dialogError('Sorry, Internal Server Error!');
          } else if(response.statusCode == 200){
            try{
              // var data = User.fromJson(response.body['data']['user']);
              // data.token = response.body['data']['token_type']+ ' ' + response.body['data']['access_token'];

              StaticData.users.clear();
              for(var i = 0; i<response.body['data']['user'].length; i++){
                if(StaticData.users.any((element) => element.id == response.body['data']['user'][i]['id'])){
                  print('pass');

                }else {
                  var data = User.fromJson(response.body['data']['user'][i]);
                  print(data.toJson());
                  StaticData.users.add(data);
                  // print(data.toJson());
                }

              }
              print(StaticData.users.length);

              change(null, status: RxStatus.success());
            }catch(e){
              print(e.toString());
              responseStatusError(null, e.toString(), RxStatus.error());
            }}else{}
        });
      }catch(e){
        responseStatusError(null, e.toString(), RxStatus.error());
      }
  }
}

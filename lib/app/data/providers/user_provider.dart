import 'package:get/get.dart';
import 'dart:io';

import '../../helpers/theme.dart';
import '../models/user_model.dart';

class UserProvider extends GetConnect {
  Future<Response> registerUser(String name, String password, String email, ) async {
    final response = await post(
      url + '/register',
        {
          "name": name,
          "email": email,
          "password": password,
          "role": "user"
        }
    );
    return response;
  }

  Future<Response> getAllUsers() async {
    final response = await get(
        url + '/users',
    );
    return response;
  }

  Future<Response> registerAgent(String name, String password, String email, File file) async {
    final response = await post(
        url + '/register',
        FormData({
          'name': name,
          'email': email,
          'password': password,
          'role': 'open trip',
          'file': MultipartFile(file, filename: 'agent_file_'+email+'.pdf'),
        })
    );
    return response;
  }

  Future<Response> verifyEmail(String otpCode, String token) async {
    final response = await post(
        url + '/verify',
        {
          "otp_code": otpCode,
        },
        headers: {'Authorization': token}
    );
    return response;
  }

  Future<Response> login(String email, String password) async {
    final response = await post(
        url + '/login',
        {
          "email": email,
          "password": password
        }
    );
    return response;
  }

}

import 'dart:io';

import 'package:get/get.dart';

import '../../helpers/theme.dart';
import '../models/feeds_model.dart';

class FeedsProvider extends GetConnect {

  Future<Response> create(String token, String description, String location, List<File> images) async {
    print("images0: ${images[0]}");
    print("images0: ${images[0].path}");
    print("images0: ${images[0].runtimeType}");
    // print("images1: ${images[1]}");
    // print("images1: ${images[1].path}");
    // print("images1: ${images[1].runtimeType}");
    try{
      var formData = FormData({
        'description': description,
        'location': location,
      });

      try{
        images.forEach((image) {
          formData.files.add(MapEntry('images[]', MultipartFile(image, filename: 'file.${image.path.split('.').last}')));
        });
      }catch(e){
        print(e.toString());
      }

      final response = await post(
          url + '/feeds/create',
          formData,
          headers: {'Authorization': token}
      );
      return response;
    }catch(e){
      print(e.toString());
      return Response();
    }
  }

  Future<Response> like(String token, int feedId) async {
    try{
      final response = await post(
          url + '/feeds/likes',
          {
            'feed_id': feedId,
          },
          headers: {'Authorization': token}
      );
      return response;
    }catch(e){
      print(e.toString());
      return Response();
    }
  }

  Future<Response> deleteLike(String token, int feedId) async {
    try{
      final response = await delete(
          url + '/feeds/likes/delete/$feedId',
          headers: {'Authorization': token}
      );
      return response;
    }catch(e){
      print(e.toString());
      return Response();
    }
  }

  Future<Response> save(String token, int feedId) async {
    try{
      final response = await post(
          url + '/feeds/saves',
          {
            'feed_id': feedId,
          },
          headers: {'Authorization': token}
      );
      return response;
    }catch(e){
      print(e.toString());
      return Response();
    }
  }

  Future<Response> deleteSave(String token, int feedId) async {
    try{
      final response = await delete(
          url + '/feeds/saves/delete/$feedId',
          headers: {'Authorization': token}
      );
      return response;
    }catch(e){
      print(e.toString());
      return Response();
    }
  }
}

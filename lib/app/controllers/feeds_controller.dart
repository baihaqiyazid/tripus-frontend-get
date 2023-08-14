import 'dart:async';
import 'dart:io';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripusfrontend/app/data/providers/feeds_provider.dart';

import '../data/models/feeds_home_model.dart';
import '../data/models/feeds_model.dart';
import '../data/static_data.dart';
import '../helpers/dialog_widget.dart';
import 'package:flutter/material.dart';

class FeedsController extends GetxController with StateMixin<Feed> {
  //TODO: Implement UserAuthController

  var userAuth = GetStorage().read('user');

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  void responseStatusError(data, message, status) {
    change(data, status: status);
    dialogError(message);
  }

  void create(String description, String location, List<File> images ) {
    if (images.isEmpty) {
      dialogError("images required");
    } else {
      change(null, status: RxStatus.loading());
      try {
        FeedsProvider()
            .create(userAuth['token'], description, location, images)
            .then((response) {
          print("resposne : ${response.body}");
          print("resposne : ${response.statusCode}");
          if (response.statusCode == 400) {
            String errors = response.body['data']['errors'];
            responseStatusError(null, errors, RxStatus.error());
          } else if (response.statusCode == 500) {
            change(null, status: RxStatus.error());
            dialogError('Sorry, Internal Server Error!');
          } else if (response.statusCode == 200) {
            print('userAuth[id]: ${ userAuth['id']}');
            print('userAuth[id]: ${ userAuth['id'].runtimeType}');
            try {
              var data = FeedsHome.fromJson(response.body['data'][0]);
              data.user = UserHome(
                id: userAuth['id'],
                name: userAuth['name'],
                profilePhotoPath: userAuth['profilePhotoPath'],
              );

              print("data json: ${data.toJson()}");
              StaticData.feeds.add(data);
              print("static data: ${StaticData.feeds.last.user}");
              change(null, status: RxStatus.success());
              print("success create feeds");
              Get.offNamed('/home');
            } catch (e) {
              print(e.toString());
              change(null, status: RxStatus.error());
            } finally {
              change(null, status: RxStatus.empty());
            }
          }
        }, onError: (e) {
          responseStatusError(null, e.toString(), RxStatus.error());
        });
      } catch (e) {
        print(e.toString());
        change(null, status: RxStatus.error());
      }
    }
  }

  void like(int feedId) {
      change(null, status: RxStatus.loading());
      try {
        FeedsProvider()
            .like(userAuth['token'], feedId)
            .then((response) {
          print("resposne : ${response.body}");
          print("resposne : ${response.statusCode}");
          if (response.statusCode == 400) {
            String errors = response.body['data']['errors'];
            responseStatusError(null, errors, RxStatus.error());
          } else if (response.statusCode == 500) {
            change(null, status: RxStatus.error());
            dialogError('Sorry, Internal Server Error!');
          } else if (response.statusCode == 200) {
            try {
              var data = FeedsHomeLikes.fromJson(response.body['data']['feed']);
              print(data.toJson());

              var feedToModify = StaticData.feeds.firstWhere(
                    (element) => element.id == feedId,
              );

              if (feedToModify != null) {
                feedToModify.feedsLikes?.add(data);
              }

              change(null, status: RxStatus.success());
              print("success like feeds");
            } catch (e) {
              print(e.toString());
              change(null, status: RxStatus.error());
            } finally {
              change(null, status: RxStatus.empty());
            }
          }
        }, onError: (e) {
          responseStatusError(null, e.toString(), RxStatus.error());
        });
      } catch (e) {
        print(e.toString());
        change(null, status: RxStatus.error());
      }
  }

  void deleteLike(int feedId) {
    change(null, status: RxStatus.loading());
    try {
      FeedsProvider()
          .deleteLike(userAuth['token'], feedId)
          .then((response) {
        print("resposne : ${response.body}");
        print("resposne : ${response.statusCode}");
        if (response.statusCode == 404) {
          String errors = response.body['data']['errors'];
          responseStatusError(null, errors, RxStatus.error());
        } else if (response.statusCode == 500) {
          change(null, status: RxStatus.error());
          dialogError('Sorry, Internal Server Error!');
        } else if (response.statusCode == 200) {
          try {
            var feedToModify = StaticData.feeds.firstWhere(
                  (element) => element.id == feedId,
            );

            if (feedToModify != null) {
              feedToModify.feedsLikes!.removeWhere((element) => element.feedId == feedId);
            }

            change(null, status: RxStatus.success());
            print("success delete feeds like");
          } catch (e) {
            print(e.toString());
            change(null, status: RxStatus.error());
          } finally {
            change(null, status: RxStatus.empty());
          }
        }
      }, onError: (e) {
        responseStatusError(null, e.toString(), RxStatus.error());
      });
    } catch (e) {
      print(e.toString());
      change(null, status: RxStatus.error());
    }
  }

  void save(int feedId) {
    change(null, status: RxStatus.loading());
    try {
      FeedsProvider()
          .save(userAuth['token'], feedId)
          .then((response) {
        print("resposne : ${response.body}");
        print("resposne : ${response.statusCode}");
        if (response.statusCode == 400) {
          String errors = response.body['data']['errors'];
          responseStatusError(null, errors, RxStatus.error());
        } else if (response.statusCode == 500) {
          change(null, status: RxStatus.error());
          dialogError('Sorry, Internal Server Error!');
        } else if (response.statusCode == 200) {
          try {
            var data = FeedsHomeLikes.fromJson(response.body['data']['feed']);
            print(data.toJson());
            // Find the feed with the specified feedId
            var feedToModify = StaticData.feeds.firstWhere(
                  (element) => element.id == feedId,
            );

            if (feedToModify != null) {
              feedToModify.feedsSaves?.add(data);
            }

            change(null, status: RxStatus.success());
            print("success like feeds");
          } catch (e) {
            print(e.toString());
            change(null, status: RxStatus.error());
          } finally {
            change(null, status: RxStatus.empty());
          }
        }
      }, onError: (e) {
        responseStatusError(null, e.toString(), RxStatus.error());
      });
    } catch (e) {
      print(e.toString());
      change(null, status: RxStatus.error());
    }
  }

  void deleteSave(int feedId) {
    change(null, status: RxStatus.loading());
    try {
      FeedsProvider()
          .deleteSave(userAuth['token'], feedId)
          .then((response) {
        print("resposne : ${response.body}");
        print("resposne : ${response.statusCode}");
        if (response.statusCode == 404) {
          String errors = response.body['data']['errors'];
          responseStatusError(null, errors, RxStatus.error());
        } else if (response.statusCode == 500) {
          change(null, status: RxStatus.error());
          dialogError('Sorry, Internal Server Error!');
        } else if (response.statusCode == 200) {
          try {
            var feedToModify = StaticData.feeds.firstWhere(
                  (element) => element.id == feedId,
            );

            if (feedToModify != null) {
              feedToModify.feedsSaves!.removeWhere((element) => element.userId == userAuth['id']);
            }

            change(null, status: RxStatus.success());
            print("success delete feeds like");
          } catch (e) {
            print(e.toString());
            change(null, status: RxStatus.error());
          } finally {
            change(null, status: RxStatus.empty());
          }
        }
      }, onError: (e) {
        responseStatusError(null, e.toString(), RxStatus.error());
      });
    } catch (e) {
      print(e.toString());
      change(null, status: RxStatus.error());
    }
  }
}

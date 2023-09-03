import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:tripusfrontend/app/data/models/user_model.dart';
import 'package:tripusfrontend/app/helpers/avatar_custom.dart';

import '../../../data/models/feeds_home_model.dart';
import '../../../data/static_data.dart';
import '../../../helpers/theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  RxList<FeedsHome>? feedsUserLogged;
  RxList<User>? users;

  ProfileView({this.feedsUserLogged = null, this.users = null});

  @override
  Widget build(BuildContext context) {
    print(users!);
    String? name = users!.first.name;
    String? userName = name != null ? toBeginningOfSentenceCase(name) : '';

    Widget buttonEditProfile() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.EDIT_PROFILE, arguments: users!.first);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 38), // Set the desired padding values
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10), // Set the desired border radius
                ),
              ),
              backgroundColor:
              MaterialStateProperty.all<Color>(textButtonSecondaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit Profile",
                  style: buttonPrimaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buttonSettings() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 16,),
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE_SETTINGS);
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 38), // Set the desired padding values
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10), // Set the desired border radius
                ),
              ),
              backgroundColor:
              MaterialStateProperty.all<Color>(containerPostColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Settings",
                  style: buttonPrimaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: semibold, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          users?.first.backgroundImageUrl != null ?
          Image.network(urlImage + users!.first.backgroundImageUrl!, width: double.infinity,
            fit: BoxFit.cover,
            height: Get.size.height / 3.5,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                // Image is fully loaded
                return child;
              } else {
                // Image is still loading, show a loading widget
                return SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      width: double.infinity,
                      height: Get.size.height / 3.5
                  ),
                ); // Replace with your LoadingWidget
              }
            },)    :
          Image.asset(
            'assets/feeds_example.png',
            width: double.infinity,
            fit: BoxFit.cover,
            height: Get.size.height / 3.5,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Container(
                    margin: EdgeInsets.only(left: 24),
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.arrow_back, color: Colors.black,))),
              )),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: Get.size.height / 4.5, right: 45, left: 45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  users?.first.profilePhotoPath == null ?
                  AvatarCustom(name: users!.first.name!,
                      width: 150,
                      height: 150,
                      color: Colors.blue,
                      fontSize: 40,
                      radius: 50) : CircleAvatar(
              radius: 60, // Set the radius to control the size of the circle
              backgroundImage: NetworkImage(urlImage +  users!.first.profilePhotoPath!),
            ),
                  const SizedBox(height: 8,),
                  Text(
                    userName!, style: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold
                  ),),
                  const SizedBox(height: 5,),
                  users?.first.bio != null ?
                  Text(users?.first.bio,
                    style: primaryTextStylePlusJakartaSans.copyWith(
                        fontSize: 12
                    ),) : Container(),

                  users?.first.id == StaticData.box.read('user')['id'] ?
                  Row(
                    children: [
                      buttonEditProfile(),
                      const SizedBox(width: 14,),
                      buttonSettings()
                    ],
                  ) : Container(),
                  Obx(() {
                    return Expanded(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            crossAxisCount: 2, // Number of columns in the grid
                            crossAxisSpacing: 2, // Spacing between columns
                            mainAxisSpacing: 2, // Spacing between rows
                          ),
                          itemCount: feedsUserLogged?.length,
                          // Number of items in the grid
                          itemBuilder: (BuildContext context, int index) {
                            String? imageUrl = feedsUserLogged?[index]
                                .feedImage![0].imageUrl;
                            return GestureDetector(
                                onTap: () =>
                                    Get.toNamed(Routes.FEED_DETAIL,
                                        arguments: users!.first.id,
                                        parameters: {
                                          'id': feedsUserLogged![index].id
                                              .toString()
                                        }),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      urlImage + imageUrl!,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Image is fully loaded
                                          return child;
                                        } else {
                                          // Image is still loading, show a loading widget
                                          return SkeletonAvatar();// Replace with your LoadingWidget
                                        }
                                      }
                                  ),
                                )
                            );
                          }
                      ),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

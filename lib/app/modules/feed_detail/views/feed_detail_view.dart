import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:tripusfrontend/app/data/models/feeds_home_model.dart';
import 'package:tripusfrontend/app/data/static_data.dart';
import 'package:tripusfrontend/app/helpers/carousel_widget.dart';

import '../../../controllers/feeds_controller.dart';
import '../../../helpers/format_datetime.dart';
import '../../../helpers/theme.dart';
import '../../main-profile/controllers/main_profile_controller.dart';

class FeedDetailView extends StatefulWidget {

  FeedDetailView();

  @override
  State<FeedDetailView> createState() => _FeedDetailViewState();
}

class _FeedDetailViewState extends State<FeedDetailView> {
  FeedsHome? feeds = StaticData.feeds.firstWhere((element) => element.id == int.parse(Get.parameters['id'] ?? '0'));

  bool like = false;
  bool isLiked = false;

  bool save = false;
  bool isSaved = false;

  int feedLikeLength = 0;

  @override
  void initState() {
    super.initState();
    Get.put(MainProfileController());
    Get.put(FeedsController());
    feedLikeLength = feeds!.feedsLikes!.length;
    if(feeds!.feedsLikes!.any((element) => element.userId == GetStorage().read('user')['id'])){
      isLiked = true;
    };

    if(feeds!.feedsSaves!.any((element) => element.userId == GetStorage().read('user')['id'])){
      isSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(feeds?.description);
    // print('id param ${Get.parameters['id']}');
    String? name = feeds!.user!.name;
    String? userName = name != null ? toBeginningOfSentenceCase(name) : '';

    List<Widget> imageSliders = feeds!
        .feedImage!
        .map((item) => Container(
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                urlImage + item.imageUrl!,
                fit: BoxFit.cover, width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    ))
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
              opacity: 0.6,
              child: Image.network(
                urlImage + feeds!.feedImage!.first.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: Get.size.height,
              )),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      AppBar(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        title: Text('Post'),
                        titleTextStyle: TextStyle(
                            fontWeight: semibold,
                            color: textPrimaryColor,
                            fontSize: 16),
                        centerTitle: true,
                        iconTheme: IconThemeData(color: textPrimaryColor),
                        leading: IconButton(
                          highlightColor: Colors.transparent,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            final MainProfileController mainProfileController = Get.find();
                            mainProfileController.updateData(GetStorage().read('user')['id']);
                            Get.back(); // Navigasi kembali ke halaman sebelumnya
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 46,
                      ),
                      FeedsCarousel(imageSliders),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.2,
                  minChildSize: 0.2,
                  maxChildSize: 0.7,
                 snap: false,
                    builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.only(left: 24, right: 24, top: 0),
                    height: Get.size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            //begin color
                            Colors.white.withOpacity(0.8),
                            //end color
                            Colors.white.withOpacity(0.9),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4), // Shadow color
                            offset: Offset(0, 2), // Shadow offset
                            blurRadius: 7, // Shadow blur radius
                            spreadRadius: 0, // Shadow spread radius
                          ),
                        ]),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatTimeAgo(feeds!.createdAt!),
                                  style: primaryTextStylePlusJakartaSans.copyWith(
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                feeds!.location != null?
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.blue,
                                    ),
                                    Container(
                                      width: Get.size.height * 0.3 ,
                                      child: Text(
                                        feeds!.location!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: primaryTextStylePlusJakartaSans.copyWith(
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ) : Container()
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if(isSaved){
                                            save = false;
                                            isSaved = !isSaved;
                                            Get.find<FeedsController>().deleteSave(feeds!.id!);
                                          }
                                          else{
                                            save = !save;
                                            isSaved = !isSaved;
                                            Get.find<FeedsController>().save(feeds!.id!);
                                          }
                                          print(isLiked);
                                        });
                                      },
                                        child:
                                        isSaved || save ?
                                        Icon(
                                          Icons.bookmark,
                                          size: 30,
                                          color: Colors.black,
                                        ): Icon(
                                          Icons.bookmark_outline,
                                          size: 30,
                                          color: Colors.black,
                                        )),
                                    Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if(isLiked){
                                                  like = false;
                                                  isLiked = !isLiked;
                                                  feedLikeLength = feedLikeLength -1;
                                                  Get.find<FeedsController>().deleteLike(feeds!.id!);
                                                }
                                                else{
                                                  like = !like;
                                                  isLiked = !isLiked;
                                                  feedLikeLength = feedLikeLength + 1;
                                                  Get.find<FeedsController>().like(feeds!.id!);
                                                }
                                                print(isLiked);
                                              });
                                            },
                                            child: isLiked || like ?
                                            Icon(Icons.favorite, color: Colors.red, size: 30,) : Icon(Icons.favorite_border, size: 30,)),
                                        Text(
                                          feedLikeLength.toString(),
                                          style: primaryTextStylePlusJakartaSans.copyWith(
                                              fontSize: 15, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName.toString(),
                              style: primaryTextStylePlusJakartaSans.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              feeds?.description ?? '',
                                  style: primaryTextStylePlusJakartaSans.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                  color: textSecondaryColor,
                                  height: 1.5
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

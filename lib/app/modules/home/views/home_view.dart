import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tripusfrontend/app/controllers/home_page_controller.dart';
import 'package:tripusfrontend/app/modules/home/views/post_feeds_view.dart';
import 'package:tripusfrontend/app/modules/home/views/widget/feeds_widget.dart';

import '../../../controllers/user_auth_controller.dart';
import '../../../data/static_data.dart';
import '../../../helpers/avatar_custom.dart';
import '../../../helpers/loading_widget.dart';
import '../../../helpers/theme.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final box =  GetStorage().read('user');

  @override
  void initState() {
    Get.lazyPut(() => UserAuthController());
    Get.lazyPut(() => HomePageController());
    Future.delayed(Duration.zero, () async {
      Get.find<HomePageController>().getData();
      Get.find<UserAuthController>().getAllUsers();
      Get.find<UserAuthController>().getAllPaymentAccountUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget category() {
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // OPEN TRIP
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 14), // Set the desired padding values
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8), // Set the desired border radius
                    ),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(textButtonSecondaryColor),
                ),
                child: Text(
                  "Open Trip",
                  style: buttonPrimaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            // SHARE COST
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 14), // Set the desired padding values
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8), // Set the desired border radius
                    ),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(textButtonSecondaryColor),
                ),
                child: Text(
                  "Share Cost",
                  style: buttonPrimaryTextStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );
    }


    return GestureDetector(
      onVerticalDragEnd: (_result) => print('drag'),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                elevation: 1,
                backgroundColor: backgroundColor,
                title: SvgPicture.asset('assets/logo.svg'),
                flexibleSpace: Container(
                    margin: EdgeInsets.only(left: 24, right: 24, top: 60),
                    child: category()
                ),

                actions: [
                  IconButton(
                    onPressed: () => Get.to(() => PostFeedsView()),
                    icon: Image.asset('assets/icon_plus.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: box['profile_photo_path'] == null
                        ? IconButton(
                      onPressed: () {
                        print('tap');
                        Get.toNamed(Routes.MAIN_PROFILE, parameters: {'id': box.id.toString()});
                      },
                          icon: AvatarCustom(
                      name: box['name'],
                      width: 40,
                      height: 10,
                      fontSize: 16,
                      radius: 20,
                      color: Colors.blueAccent,
                    ),
                        )
                        : IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.MAIN_PROFILE, parameters: {'id': box['id'].toString()});
                      },
                      icon: CircleAvatar(
                        radius: 50, // Set the radius to control the size of the circle
                        backgroundImage: NetworkImage(urlImage + box['profile_photo_path']),
                      ),
                    ),
                  ),
                ],
                expandedHeight: kToolbarHeight + 60,
                floating: true,
              ),
              GetBuilder<HomePageController>(builder: (controller) {
                if(controller.status.isSuccess){
                  return SliverToBoxAdapter(
                    child: Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ...StaticData.feeds.map((e) =>
                                  FeedsWidget(feeds: e,)).toList(),
                              SizedBox(height: Get.size.height / 7.5,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return SliverToBoxAdapter(child: Center(child: Container(
                    margin: EdgeInsets.only(top: 20),
                      child: LoadingWidget()),));
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

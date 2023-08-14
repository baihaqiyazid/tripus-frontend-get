import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:tripusfrontend/app/controllers/user_auth_controller.dart';
import 'package:tripusfrontend/app/helpers/carousel_widget.dart';
import 'package:tripusfrontend/app/helpers/loading_widget.dart';
import 'package:tripusfrontend/app/modules/home/views/widget/place_Search.dart';

import '../../../controllers/feeds_controller.dart';
import '../../../helpers/theme.dart';

class PostFeedsView extends StatefulWidget {
  const PostFeedsView({Key? key}) : super(key: key);

  @override
  State<PostFeedsView> createState() => _PostFeedsViewState();
}

class _PostFeedsViewState extends State<PostFeedsView> {
  List<MapBoxPlace> places = [];

  File? image;
  List<File> imageList = [];

  TextEditingController locationController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');

  final ValueNotifier<String> searchText = ValueNotifier('');

  var placesSearch = PlacesSearch(
    apiKey:
        'pk.eyJ1IjoiYmFpaGFxeSIsImEiOiJjbGpzODBuMDMwYmo0M2p2c2JneXE2MGlrIn0.xeSSV9yBJ-nTKgbh2JrOhQ',
    limit: 10,
    country: 'ID',
  );

  void clearPlaces() {
    setState(() {
      places.clear(); // Clear the places list
    });
  }

  Future<List<MapBoxPlace>> getPlaces(String name) async {
    try {
      final result = await placesSearch.getPlaces(name);
      print("result: ${result}");

      setState(() {
        places = result!;
      });
      return places;
    } catch (e) {
      // Handle error jika terjadi exception
      print("Error: $e");
      setState(() {
        places = [];
      });
      return [];
    }
  }

  Future takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera, maxHeight: 2000, maxWidth: 2000);
    if (photo != null) {
      print("photo ${photo}");
      setState(() {
        image = File(photo.path);
        print("photo path ${image}");
        imageList.add(image!);
      });
    }
    print("image: ${image!.path}");
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    print("photo ${photo}");
    if (photo != null) {
      setState(() {
        image = File(photo.path);
        print("photo path ${image}");
        imageList.add(image!);
      });
    }
    print("image: ${image!.path}");
  }

  Timer? _timer;

  @override
  void initState(){
    Get.put(FeedsController());
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> imageSliders = imageList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Stack(
                  children: [
                    Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.file(
                            item,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        bottom: 0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                imageList
                                    .removeWhere((element) => element == item);
                              });
                            },
                            iconSize: 30,
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ))
        .toList();

    Widget uploadImage() {
      return Container(
        height: 200,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 27, horizontal: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: containerPostColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        print("hello");
                        await takePhoto();
                      },
                      iconSize: 30,
                      icon: Icon(
                        Icons.camera_enhance_rounded,
                        color: Colors.black38,
                      )),
                  VerticalDivider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                  IconButton(
                      onPressed: () async {
                        print("hello");
                        await getImage();
                      },
                      iconSize: 30,
                      icon: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.black38,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tap to choose",
                  style: primaryTextStylePlusJakartaSans.copyWith(
                      color: Color(0xffA1A1A1), fontSize: 10),
                ),
                Text(
                  "Image",
                  style: primaryTextStylePlusJakartaSans.copyWith(
                      color: textButtonSecondaryColor, fontSize: 10),
                ),
              ],
            )
          ],
        ),
      );
    }

    if (imageList.length < 3) {
      imageSliders.add(uploadImage());
    }

    Widget description() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: primaryTextStylePlusJakartaSans.copyWith(
                fontSize: 12, fontWeight: semibold),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: containerPostColor,
            ),
            child: TextFormField(
              textAlign: TextAlign.justify,
              style: primaryTextStylePlusJakartaSans.copyWith(fontSize: 12),
              maxLines: 6,
              controller: descriptionController,
              decoration: InputDecoration.collapsed(
                hintText: "Type Here...",
                hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                    color: Color(0xffA1A1A1), fontSize: 12),
              ),
            ),
          ),
        ],
      );
    }

    Widget location() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: primaryTextStylePlusJakartaSans.copyWith(
                fontSize: 12,
                fontWeight: semibold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              height: 40,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: containerPostColor,
              ),
              child: ValueListenableBuilder<String>(
                valueListenable: searchText,
                builder: (context, value, child) {
                  return TextFormField(
                    scrollPadding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).viewInsets.bottom),
                    controller: locationController,
                    onChanged: (newValue) {
                      searchText.value = newValue;
                      getPlaces(newValue);
                    },
                    textAlign: TextAlign.justify,
                    style:
                        primaryTextStylePlusJakartaSans.copyWith(fontSize: 12),
                    maxLines: 1,
                    decoration: InputDecoration.collapsed(
                      hintText: "Type Here...",
                      hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                        color: Color(0xffA1A1A1),
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
            places.length != 0
                ? Container(
                    margin: EdgeInsets.only(top: 5),
                    width: double.infinity,
                    height: 400,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: containerPostColor,
                    ),
                    child: ListView(
                      children: [
                        ...places
                            .map((place) => LocationItem(
                                  place: place,
                                  locationController: locationController,
                                  onClearPlaces: clearPlaces,
                                ))
                            .toList(),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      );
    }
    if(imageList.isNotEmpty) print('imageList: ${imageList.length}');

    // Get.put<UserAuthController>;
    final controller = Get.find<FeedsController>();
    return controller.obx(
      (state) {
        return Center(child:Text('success'));
      },
      onError: (error) => Center(child:Text(error.toString())) ,
      onLoading: Center(child: LoadingWidget()),
      onEmpty: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 15),
          // Ukuran tinggi AppBar dengan margin vertical
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20), // Margin horizontal
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text("Post Photo"),
              titleTextStyle: TextStyle(
                  fontWeight: semibold, color: textPrimaryColor, fontSize: 16),
              centerTitle: true,
              iconTheme: IconThemeData(color: textPrimaryColor),
              actions: [
                TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Get.find<FeedsController>().create(
                        descriptionController.text,
                        locationController.text,
                        imageList
                    );
                  },
                  child: Text(
                    "Done",
                    style: buttonSecondaryTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              toolbarHeight: kToolbarHeight + 15,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageList.isNotEmpty
                          ? FeedsCarousel(imageSliders)
                          : uploadImage(),
                      description(),
                      location(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

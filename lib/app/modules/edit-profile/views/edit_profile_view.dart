import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tripusfrontend/app/helpers/avatar_custom.dart';

import '../../../helpers/theme.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget uploadPhoto(){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(64),
              topLeft: Radius.circular(64),
            ),
            color: Colors.white
        ),
        height: 100,
        child: Column(
          children: [
            Text(
              'Change From',
              style: primaryTextStylePlusJakartaSans.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){},
                  child: Text(
                    'Take Photo',
                    style: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Text(
                    'Upload Photo',
                    style: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget header() {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/feeds_example.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              GestureDetector(
                onTap: () => Get.bottomSheet(uploadPhoto()),
                child: Column(children: [
                  Icon(
                    Icons.camera_enhance_rounded,
                    color: Colors.black,
                  ),
                  Text(
                    'Change Background',
                    style: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.bottomSheet(uploadPhoto());
            },
            child: Container(
              margin: EdgeInsets.only(top: Get.size.height * 0.26),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  AvatarCustom(
                      name: 'Baihaqi',
                      width: 80,
                      height: 80,
                      color: Colors.blue,
                      fontSize: 24,
                      radius: 50),
                  Icon(
                    Icons.camera_enhance_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    Widget nameInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: primaryTextStylePlusJakartaSans.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: textHintColor, width: 0.4))),
            child: TextFormField(
              style: primaryTextStylePlusJakartaSans,
              decoration: InputDecoration.collapsed(
                  hintText: "Baihaqi",
                  hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    Widget bioInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bio',
            style: primaryTextStylePlusJakartaSans.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: textHintColor, width: 0.4))),
            child: TextFormField(
              style: primaryTextStylePlusJakartaSans,
              decoration: InputDecoration.collapsed(
                  hintText: "Traveler enthusiast",
                  hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    Widget linkInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Links',
            style: primaryTextStylePlusJakartaSans.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              style: primaryTextStylePlusJakartaSans,
              decoration: InputDecoration.collapsed(
                  hintText: "Add links",
                  hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15, color: textHintColor)),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    Widget emailInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: primaryTextStylePlusJakartaSans.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: textHintColor, width: 0.4))),
            child: TextFormField(
              style: primaryTextStylePlusJakartaSans,
              decoration: InputDecoration.collapsed(
                  hintText: "add email",
                  hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15, color: textHintColor)),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    Widget phoneInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Phone',
            style: primaryTextStylePlusJakartaSans.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: textHintColor, width: 0.4))),
            child: TextFormField(
              style: primaryTextStylePlusJakartaSans,
              decoration: InputDecoration.collapsed(
                  hintText: "Add your phone number",
                  hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15, color: textHintColor)),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    Widget birthdayInput() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Birthday',
            style: primaryTextStylePlusJakartaSans.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              style: primaryTextStylePlusJakartaSans,
              decoration: InputDecoration.collapsed(
                  hintText: "Add your birthday",
                  hintStyle: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15, color: textHintColor)),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style: primaryTextStylePlusJakartaSans.copyWith(
                      fontSize: 15,
                      fontWeight: medium,
                      color: textSecondaryColor),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Done',
                  style: primaryTextStylePlusJakartaSans.copyWith(
                    fontSize: 15,
                    fontWeight: semibold,
                    color: Colors.blueAccent,
                  ),
                ),
              )
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Edit Profile',
              style: primaryTextStylePlusJakartaSans.copyWith(
                fontSize: 15,
                fontWeight: semibold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
              child: Column(
                children: [
                  nameInput(),
                  SizedBox(
                    height: 10,
                  ),
                  bioInput(),
                  SizedBox(
                    height: 10,
                  ),
                  linkInput()
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Personal Information',
                  style: primaryTextStylePlusJakartaSans.copyWith(
                    fontSize: 15,
                    fontWeight: semibold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
              child: Column(
                children: [
                  emailInput(),
                  SizedBox(
                    height: 10,
                  ),
                  phoneInput(),
                  SizedBox(
                    height: 10,
                  ),
                  birthdayInput(),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

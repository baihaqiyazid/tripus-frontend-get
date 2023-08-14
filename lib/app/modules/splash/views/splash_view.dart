import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../landing/views/landing_view.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      print("read storage ${GetStorage().read('user')}");
      if (GetStorage().read('user') != null) {
        Get.offNamed('/home');
      } else {
        Get.to(() => LandingView());
      }
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.size.height,
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/logo.svg'),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'app/routes/app_pages.dart';

void setupTimeAgoShortMessages() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
}

void main() async{
  debugPaintSizeEnabled = false;
  setupTimeAgoShortMessages();
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),

    ),
  );
}

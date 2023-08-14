import 'package:get/get.dart';

import '../controllers/feeds_like_controller.dart';

class FeedsLikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedsLikeController>(
      () => FeedsLikeController(),
    );
  }
}

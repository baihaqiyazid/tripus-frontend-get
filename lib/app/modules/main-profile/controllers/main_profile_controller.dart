import 'package:get/get.dart';

import '../../../data/models/feeds_home_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/static_data.dart';

class MainProfileController extends GetxController {
  //TODO: Implement MainProfileController
  RxList<FeedsHome> feedsUserLogged = RxList<FeedsHome>([]);
  RxList<FeedsHome> feedsLikeUserLogged = RxList<FeedsHome>([]);
  RxList<FeedsHome> feedsSaveUserLogged = RxList<FeedsHome>([]);
  RxList<User> usersData = RxList<User>([]);

  void updateData(int newIndexValue) {
    print('dipanggil');
    feedsUserLogged.assignAll(StaticData.feeds
        .where((element) => element.userId == newIndexValue)
        .toList());

    feedsLikeUserLogged.assignAll(StaticData.feeds.where((element) =>
        element.feedsLikes!.any((elementLike) => elementLike.userId == newIndexValue)).toList());

    feedsSaveUserLogged.assignAll(StaticData.feeds.where((element) =>
        element.feedsSaves!.any((elementSave) => elementSave.userId == newIndexValue)).toList());

    usersData.assignAll(StaticData.users.where((element) => element.id == newIndexValue).toList());
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

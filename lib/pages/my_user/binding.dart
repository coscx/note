import 'package:flutter_note/pages/friend/logic.dart';
import 'package:get/get.dart';

import '../search/logic.dart';
import 'logic.dart';

class MyUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyUserLogic());
    Get.lazyPut(() => FriendLogic());
    Get.lazyPut<SearchLogic>(() => SearchLogic());
  }
}

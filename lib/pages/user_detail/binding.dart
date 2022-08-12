import 'package:flutter_note/pages/search/logic.dart';
import 'package:flutter_note/pages/search/view.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UserDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserDetailLogic());
    Get.lazyPut(() => SearchLogic());
  }
}

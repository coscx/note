import 'package:get/get.dart';

import 'logic.dart';

class HandBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HandLogic());
  }
}

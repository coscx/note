import 'package:flutter_note/pages/conversion/logic.dart';
import 'package:flutter_note/pages/conversion/view.dart';
import 'package:flutter_note/pages/flow_page/logic.dart';
import 'package:flutter_note/pages/frame/login/logic.dart';
import 'package:flutter_note/pages/home/logic.dart';
import 'package:flutter_note/pages/main/index.dart';
import 'package:flutter_note/pages/oa/home_message/logic.dart';
import 'package:flutter_note/pages/oa/person/logic.dart';
import 'package:flutter_note/pages/oa/work/logic.dart';
import 'package:flutter_note/pages/peer_chat/logic.dart';
import 'package:get/get.dart';

import 'controller.dart';

class OAApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OAApplicationController>(() => OAApplicationController());
    Get.lazyPut<HomeMessageLogic>(() => HomeMessageLogic());
    Get.lazyPut<PersonLogic>(() => PersonLogic());
    Get.lazyPut<WorkLogic>(() => WorkLogic());

  }
}

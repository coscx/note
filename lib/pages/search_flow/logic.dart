import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/apis/common.dart';
import '../../common/entities/home/common.dart';
import '../oa/user_detail/widget/common_dialog.dart';
import 'state.dart';

class SearchFlowLogic extends GetxController {
  final SearchFlowState state = SearchFlowState();
  List<SelectItem> selectItems = Get.arguments;
  TextEditingController titleController = TextEditingController();
  FocusNode titleFieldNode = FocusNode();
  TextEditingController contentController = TextEditingController();
  FocusNode contentFieldNode = FocusNode();
  String selectDate = "";
  @override
  void onInit() {
    super.onInit();
  }
  addChannels() async {
    if(titleController.text ==""){
      showToastRed(Get.context!, "标题不能为空", false);
      return;
    }
    if(contentController.text ==""){
      showToastRed(Get.context!, "内容不能为空", false);
      return;
    }
    var d = await CommonAPI.createNote({"title":titleController.text,"content":contentController.text,"select_date":selectDate});
    if(d.code ==200){
      showToast(Get.context!, d.msg!, false);
      titleController.text="";
      contentController.text="";
    }else{
      showToastRed(Get.context!, d.msg!, false);
    }
  }
}

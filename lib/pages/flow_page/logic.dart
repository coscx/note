import 'package:flutter/cupertino.dart';
import 'package:flutter_note/common/apis/common.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../common/entities/home/common.dart';
import '../../common/entities/loan/note.dart';
import '../oa/user_detail/widget/common_dialog.dart';
import 'state.dart';

class FlowPageLogic extends GetxController {
  final FlowPageState state = FlowPageState();
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  TextEditingController appointController = TextEditingController();
  FocusNode remarkFieldNode = FocusNode();
  List<NoteDataData> wxUser = <NoteDataData>[];
  String categoryCode = '';
  int curPage = 1;
  int pageSize = 20;
  int total = 20;
  List<SelectItem> selectItems = <SelectItem>[];
  @override
  void onInit() {
    _loadData();
    super.onInit();
  }
  addChannels() async {
      var d = await CommonAPI.createNote({});
      if(d.code ==200){
        showToast(Get.context!, d.msg!, false);
        appointController.text="";
        SmartDialog.dismiss();
        onRefresh();
      }else{
        showToastRed(Get.context!, d.msg!, false);
      }
  }
  // 下拉刷新
  void _loadData() async {
    var result =
        await CommonAPI.getNoteList({});
    wxUser.addAll(result.data!.data!) ;
    update();
  }

  // 下拉刷新
  void onRefresh() async {

    curPage=1;
    var result =
    await CommonAPI.getNoteList({});
    wxUser.clear();
    wxUser.addAll(result.data!.data!) ;
    //debugPrint(result.toString());
    refreshController.refreshCompleted();
    update();
  }

  // 上拉加载
  void onLoading() async {
    curPage++;
    var result =
    await CommonAPI.getNoteList({"currentPage":curPage});
    wxUser.addAll(result.data!.data!) ;
    refreshController.loadComplete();
    update();
  }

}

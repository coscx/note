import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/apis/common.dart';
import 'package:flutter_note/common/entities/detail/action.dart';
import 'package:flutter_note/common/entities/detail/appoint.dart';
import 'package:flutter_note/common/entities/detail/calllog.dart';
import 'package:flutter_note/common/entities/detail/connect.dart';
import 'package:flutter_note/common/entities/detail/user_detail.dart';
import 'package:flutter_note/pages/user_detail/widget/bottom_dialog.dart';
import 'package:flutter_note/pages/user_detail/widget/bottom_sheet.dart';
import 'package:flutter_note/pages/user_detail/widget/common_dialog.dart';
import 'package:flutter_note/pages/user_detail/widget/detail_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:url_launcher/url_launcher.dart';

import './widget/detail_common.dart';
import './widget/detail_item.dart';
import '../../../common/values/cons.dart';
import '../../../common/widgets/dy_behavior_null.dart';
import '../../../common/widgets/pop_button.dart';
import '../../../common/widgets/refresh.dart';
import 'logic.dart';

class OAUserDetailPage extends StatelessWidget {
  final logic = Get.find<OAUserDetailLogic>();
  final state = Get
      .find<OAUserDetailLogic>()
      .state;

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light, // Status bar
            ),
          ),
        ),
        child: Obx(() =>
            Scaffold(
              //endDrawer: CategoryEndDrawer(),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  titleSpacing: 0.w,
                  leadingWidth: 80.w,
                  centerTitle: true,
                  //??????Appbar????????????
                  leading: Container(
                    padding: EdgeInsets.only(top: 0.h),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  title: Container(
                    padding: EdgeInsets.only(top: 0.h),
                    child: Row(
                      children: [
                        Text("????????????",
                            style: TextStyle(
                              //fontFamily: "Quicksand",
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              fontSize: 38.sp,
                              decoration: TextDecoration.none,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      children: [
                        _buildCallButton(),

                        _buildConnectButton(),

                      ],
                    ),
                  ],
                ),
                body:
                logic.load.value == 0 ? Container() : _buildContent(context))));
  }

  Widget _buildRightMenu() {
    return Container(
      padding: EdgeInsets.only(right: 10.h, top: 10.h),
      child: PopButton(
        popCtrl: logic.popCtrl,
        menuBgColor: const Color(0xFFFFFFFF),
        showArrow: false,
        menuBgShadowColor: const Color(0xFF000000).withOpacity(0.16),
        menuBgShadowBlurRadius: 6,
        menuBgShadowSpreadRadius: 2,
        menuItemTextStyle: TextStyle(
          fontSize: 28.sp,
          color: const Color(0xFF333333),
        ),
        menuItemHeight: 76.h,
        // menuItemWidth: 170.w,
        menuItemPadding: EdgeInsets.only(left: 30.w, right: 30.w),
        menuBgRadius: 6,
        menuItemIconSize: 48.h,
        menus: [
          PopMenuInfo(
            text: "????????????",
            icon: "assets/images/get_user.webp",
            onTap: () => logic.getUser(),
          ),
          PopMenuInfo(
            text: "????????????",
            icon: "assets/images/change_user.webp",
            onTap: () => logic.changeUser(),
          ),
          PopMenuInfo(
            text: "????????????",
            icon: "assets/images/vip.webp",
            onTap: () => logic.addVip(),
          ),
        ],
        child: TitleImageButton(
          imageStr: "assets/images/ic_keyboard.webp",
          imageHeight: 80.h,
          imageWidth: 80.w,
          // onTap: (){},
          // onTap: onClickAddBtn,
          // height: 50.h,
        ),
      ),
    );
  }


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  List<PopupMenuItem<String>> buildItems() {
    final map = {
      "???????????????": Icons.archive_outlined,
      "????????????": Icons.copyright_rounded,
      "????????????": Icons.pivot_table_chart,
    };
    return map.keys
        .toList()
        .map((e) =>
        PopupMenuItem<String>(
            value: e,
            child: Wrap(
              spacing: 5.h,
              children: <Widget>[
                Icon(
                  map[e],
                  color: Colors.black,
                ),
                Text(e),
              ],
            )))
        .toList();
  }

  Widget _buildContent(BuildContext context) =>
      WillPopScope(
          onWillPop: () => _whenPop(context),
          child: ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: DYrefreshHeader(),
                  footer: DYrefreshFooter(),
                  controller: logic.refreshController,
                  onRefresh: logic.onRefresh,
                  onLoading: logic.onLoading,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildTitle(context),
                        _buildDetail(context)
                      ],
                    ),
                  ))));

  Widget _buildAppointButton() =>
      Builder(
          builder: (ctx) =>
              GestureDetector(
                  onLongPress: () => Scaffold.of(ctx).openEndDrawer(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: Container(
                      width: 60.h,
                      height: 60.h,
                      margin: EdgeInsets.fromLTRB(10.w, 0.h, 5.w, 0.h),
                      child: Lottie.asset(
                          'assets/packages/lottie_flutter/appointment.json'),
                    ),
                  ),
                  onTap: () async {
                    if (logic.canEdit == 1) {
                      var d = await appointDialog(Get.context!, logic.uuid);
                      if (d == true) {
                        logic.buildAppointButton();
                      }
                    } else {
                      showToastRed(ctx, "????????????", true);
                    }
                  }));

  Widget _buildCallButton() =>
      Builder(
          builder: (ctx) =>
              GestureDetector(
                  onLongPress: () => Scaffold.of(ctx).openEndDrawer(),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.h),
                    child: Container(
                      width: 60.h,
                      height: 60.h,
                      margin: EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0.h),
                      child: Lottie.asset(
                          'assets/packages/lottie_flutter/phone-call.json'),
                    ),
                  ),
                  onTap: () async {

                    showDialog(
                        barrierDismissible: true, //???????????????????????????????????????,?????????true???????????????
                        context: Get.context!,
                        builder: (BuildContext context) {
                          var list = [];
                          list.add('????????????');
                          list.add('????????????');
                          return BottomSheetWidget(
                            list: list,
                            onItemClickListener: (index) async {
                              if (index == 0) {
                                var actionList = await CommonAPI.viewCall(
                                    logic.uuid);
                                if (actionList.code == 200) {
                                  showCupertinoAlertDialog(actionList.data);
                                } else {
                                  showToast(ctx, "????????????", true);
                                }
                              }
                              if (index == 1) {
                                var actionList = await CommonAPI.viewCall(
                                    logic.uuid);
                                if (actionList.code == 200) {
                                  _makePhoneCall(actionList.data);
                                } else {
                                  showToast(ctx, "????????????", true);
                                }
                              }
                            },
                          );
                        });
                  }));

  Widget _buildConnectButton() {
    return GestureDetector(
      onTap: () async {

          var d = await commentDialog(
              Get.context!, logic.connectStatus, logic.userDetail!.info,logic.uuid);
          if (d == true) {
            logic.buildConnectButton();
          }

      },
      child: Padding(
        padding: EdgeInsets.only(right: 20.0, top: 0.h),
        child: Container(
          width: 60.h,
          height: 60.h,
          margin: EdgeInsets.fromLTRB(10.w, 5.h, 5.w, 0.h),
          child: Lottie.asset('assets/packages/lottie_flutter/chat.json'),
        ),
      ),
    );
  }

  showBottomAlert(BuildContext context, confirmCallback, String title,
      String option1, String option2) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return BottomCustomAlterWidget(
              confirmCallback, title, option1, option2);
        });
  }

  void showCupertinoAlertDialog(String mobile) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("????????????"),
            content: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  child: Text(mobile),
                  alignment: const Alignment(0, 0),
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text("??????"),
                onPressed: () {
                  Navigator.pop(context);
                  debugPrint("??????");
                },
              ),
              CupertinoDialogAction(
                child: const Text("??????"),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: mobile));
                  showToast(context, "????????????", true);
                  Navigator.pop(context);
                  debugPrint("??????");
                },
              ),
            ],
          );
        });
  }

  final List<int> colors = Cons.tabColors;

  Future<bool> _whenPop(BuildContext context) async {
    return true;
  }

  List<Widget> _listViewConnectList(List<Connect> connectList) {
    return connectList
        .map((e) =>
        item_connect(
            Get.context!,
            e.username,
            e.connectTime,
            e.connectMessage,
            e.subscribeTime.toString(),
            e.connectStatus.toString(),
            e.connectType.toString(),
            logic.userDetail!.info.roleId))
        .toList();
  }

  List<Widget> _listViewAppointList(List<Appoint> connectList) {
    return connectList
        .map((e) =>
        item_appoint(
            Get.context!,
            e.username,
            e.otherName,
            e.appointmentAddress,
            e.appointmentTime,
            e.canWrite.toString(),
            e.remark.toString(),
            e.message.toString(),
            e.otherId.toString(),
            e.id,
            logic.uuid,
            logic.canEdit))
        .toList();
  }

  List<Widget> _listViewActionList(List<UserAction> connectList) {
    return connectList
        .map((e) =>
        itemAction(Get.context!, e.username, e.title, e.content,
            e.createdAt.toString()))
        .toList();
  }

  List<Widget> _listViewCallList(List<CallLog> connectList) {
    return connectList
        .map((e) =>
        itemCall(Get.context!, e.username, e.count.toString(),
            e.updatedAt.toString()))
        .toList();
  }

  Widget _buildDetail(BuildContext context) {
    return _buildStateDetail(context, logic.userDetail!, logic.connectList,
        logic.appointList, logic.actionList, logic.callList);

    // return Container(
    //   child: Container(
    //     margin: EdgeInsets.only(
    //         top: 300.h,
    //         left: ScreenUtil().screenWidth / 2 - 50.h,
    //         right: ScreenUtil().screenWidth / 2 - 50.h),
    //     height: 100.h,
    //     width: 100.w,
    //     alignment: Alignment.center,
    //     child: Lottie.asset(
    //         'assets/packages/lottie_flutter/16379-an-ios-like-loading.json'),
    //   ),
    // );
  }

  Widget _buildStateDetail(BuildContext context,
      Data userDetails,
      List<Connect> connectList,
      List<Appoint> appointList,
      List<UserAction> actionList,
      List<CallLog> callList) {
    void callSetState(String tag, bool value) {
      logic.callSetState(tag, value);
    }

    var info1 = userDetails.info;
    logic.canEdit = userDetails.canEdit;
    logic.call = info1.mobile;
    logic.uuid = info1.uuid;
    logic.status = info1.status;

    if (connectList.isNotEmpty) {
      Connect e = connectList.first;
      logic.connectStatus = e.connectStatus;
    }
    List<Widget> connectListView = _listViewConnectList(connectList);
    List<Widget> appointListView = _listViewAppointList(appointList);
    List<Widget> actionListView = _listViewActionList(actionList);
    List<Widget> callListView = _listViewCallList(callList);

    //String level = getLevel(info['status']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GetBuilder<OAUserDetailLogic>(
          id: "oa_user_detail",
            builder: (logic) {
          return Column(
            children: [
              buildBase(
                  context, logic.userDetail!.info, logic.canEdit, logic.showBaseControl.value,
                  callSetState, "base"),

            ],
          );
        }),

        buildConnect(
            connectListView, logic.showConnectControl.value, callSetState,
            "connect"),

        buildCall(
            callListView, logic.showCallControl.value, callSetState, "call"),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return header(context, logic.userDetail!);
  }
}

class TitleImageButton extends StatelessWidget {
  const TitleImageButton({
    Key? key,
    required this.imageStr,
    required this.imageWidth,
    required this.imageHeight,
    this.width,
    this.height,
    this.onTap,
    this.padding,
    this.color,
  }) : super(key: key);
  final String imageStr;
  final double imageWidth;
  final double imageHeight;
  final double? width;
  final double? height;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 44.h,
        child: Center(
          child: Image.asset(
            imageStr,
            width: imageWidth,
            height: imageHeight,
            color: color,
          ),
        ),
        padding: padding ?? EdgeInsets.only(left: 10.w, right: 10.w),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/common/widgets/eve_button.dart';
import 'package:flutter_note/pages/search_flow/widget/wx_search_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/widgets/bottom_picker/bottom_picker.dart';
import '../../common/widgets/bottom_picker/resources/arrays.dart';
import '../../common/widgets/dy_behavior_null.dart';
import 'logic.dart';

class SearchFlowPage extends StatelessWidget {
  final logic = Get.find<SearchFlowLogic>();
  final state = Get
      .find<SearchFlowLogic>()
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
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
          elevation: 0,
          title:
          Text("添加内容",
              style: TextStyle(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold)),
        ),
        body: GetBuilder<SearchFlowLogic>(builder: (logic) {
          return GestureDetector(
            onTap: () {
              logic.titleFieldNode.unfocus();
              logic.contentFieldNode.unfocus();
            },
            child: ScrollConfiguration(
              behavior: DyBehaviorNull(),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(40.w)),
                      ),
                      child: Column(
                        //alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[

                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 20.h),
                                height: 80.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        autofocus: false,
                                        controller: logic.titleController,
                                        focusNode: logic.titleFieldNode,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        minLines: 7,
                                        maxLines: 7,
                                        cursorColor: Colors.blue,
                                        //cursorRadius: Radius.circular(40.h),
                                        cursorWidth: 3.w,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 40.w,
                                              right: 0,
                                              top: 50.h,
                                              bottom: 0),
                                          hintText: "请输入标题",
                                          hintStyle:
                                          const TextStyle(color: Colors.blue),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.h)),),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40.h)),
                                            borderSide:
                                            BorderSide(color: Colors.blue),
                                          ),
                                        ),
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(color: Colors.white,
                                margin: EdgeInsets.only(
                                    left: 80.w, right: 80.w, top: 20.h),
                                //  height: 450.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        controller: logic.contentController,
                                        focusNode: logic.contentFieldNode,
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.w400),
                                        minLines: 10,
                                        maxLines: 50,
                                        cursorColor: Colors.blue,
                                        //cursorRadius: Radius.circular(40.h),
                                        cursorWidth: 3.w,
                                        showCursor: true,
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 40.w,
                                              right: 40.w,
                                              top: 20.h,
                                              bottom: 0),
                                          hintText: "请输入内容",
                                          hintStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 32.sp),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.h)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.h)),
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.h),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.h)),
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 2.h),
                                          ),
                                        ),
                                        onChanged: (v) {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  logic.titleFieldNode.unfocus();
                                  logic.contentFieldNode.unfocus();
                                  BottomPicker.date(
                                      initialDateTime:
                                      DateTime.tryParse(logic.selectDate),
                                      height: 600.h,
                                      buttonTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32.sp),
                                      buttonSingleColor: Colors.green,
                                      displayButtonIcon: false,
                                      buttonText: "确定",
                                      title: "选择日期",
                                      titleStyle: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 38.sp,
                                          color: Colors.black),
                                      onChange: (index) {
                                        //print(index);
                                      },
                                      onSubmit: (index) {
                                        // print(index);

                                        logic.selectDate =
                                            DateFormat("yyyy-MM-dd")
                                                .format(index);
                                        logic.update();
                                      },
                                      bottomPickerTheme:
                                      BottomPickerTheme.plumPlate)
                                      .show(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 80.w, right: 80.w, top: 30.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40.h),
                                    border: Border.all(
                                        color: Colors.blue, width: 1), //边框
                                  ),
                                  height: 80.h,
                                  child: Container(
                                      padding: EdgeInsets.only(left: 40.w),
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            logic.selectDate == ""
                                                ? "请选择放款时间"
                                                : logic.selectDate,
                                            style: TextStyle(
                                                color: logic.selectDate == ""
                                                    ? Colors.blue
                                                    : Colors.redAccent,
                                                fontSize: logic.selectDate == ""
                                                    ? 32.sp
                                                    : 38.sp),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                              Container(
                                width: ScreenUtil().screenWidth,
                                height: 80.h,
                                margin:
                                EdgeInsets.only(top: 20.h,
                                    left: 40.w,
                                    right: 40.w,
                                    bottom: 40.h),
                                child: getEveButton(
                                      () {
                                    logic.addChannels();
                                  },
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

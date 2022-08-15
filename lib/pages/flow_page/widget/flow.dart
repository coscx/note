import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_note/pages/flow_page/logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common/entities/loan/note.dart';
const String defaultImg =
    'https://img.bosszhipin.com/beijin/mcs/useravatar/20171211/4d147d8bb3e2a3478e20b50ad614f4d02062e3aec7ce2519b427d24a3f300d68_s.jpg';
final _random = Random();
int next(int min, int max) => min + _random.nextInt(max - min);

class MyFlow extends StatelessWidget {
  final List<NoteDataData> liveData;

  MyFlow({required this.liveData});
  final logic = Get.find<FlowPageLogic>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.h),
      color: Colors.transparent,
      child: Column(children: <Widget>[
        //_listTableHeader(),
        _listTableInfo(context, liveData),
      ]),
    );
  }

  String getExt(String name) {
    var m = "";
    var d = name.split(".");
    for (int i = 0; i < d.length; i++) {
      m = d[i];
    }
    return m;
  }

  Widget _listTableInfo(context, List<NoteDataData> liveData) {
    final liveList = <Widget>[];
    liveData.asMap().keys.forEach((index) {
      NoteDataData item = liveData[index];
      liveList.add(
        Container(
          width: 330.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(14.w),
              )),
          key: ObjectKey(item.id),
          padding:
              EdgeInsets.only(left: 40.w, right: 40.w,top: 20.h, bottom: 20.h),
          margin: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 20.h),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 200.h,
                                child: Text(item.content),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
              GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    width: ScreenUtil().screenWidth / 2 - 50.w,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        SizedBox(

                          child: Row(children: [
                            Container(
                              //width: 80.w,
                              padding: EdgeInsets.only(left: 0.w, right: 0.w,top: 10.h),
                              //width: 200.w,
                              child: Text(
                                item.dateTime,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 23.sp,
                                ),
                              ),
                            ),

                          ]),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    });

    return Wrap(
      children: liveList,
    );
  }


}

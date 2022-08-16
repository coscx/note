import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/pages/hand/widget/note_painter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteBoard extends StatefulWidget {
  const NoteBoard({Key? key}) : super(key: key);

  @override
  State<NoteBoard> createState() => _NoteBoardState();
}

class _NoteBoardState extends State<NoteBoard> {
  Map<String, GlobalKey<NotePainterState>> m = Map();
  List<Widget> widgetList = <Widget>[];

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
      child: WillPopScope(
        onWillPop: () async {
          m.forEach((key, value) {
            if (value.currentState != null) {
              if (!value.currentState!.remove) {
                value.currentState?.onRemove();
              }
            }
          });
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("画板",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold)),
            actions: [
              Container(
                padding: EdgeInsets.only(right: 40.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {

                        GlobalKey<NotePainterState> s2 = GlobalKey();
                        m["13"] = s2;
                        widgetList.add(
                            NotePainter(key: s2, offset: Offset(100.w, 400.h), w: Container(
                              child: Image.asset("assets/images/note/c11.png",fit: BoxFit.fill,),
                            ),
                              height: 600.h,
                              width: 600.w,
                            ));

                        // GlobalKey<NotePainterState> s1 = GlobalKey();
                        // m["12"] = s1;
                        // widgetList.add(NotePainter(
                        //   key: s1,
                        //   offset: Offset(50.w, 100.h), w: Container(
                        //   child: Image.asset("assets/images/note/b40.png"),
                        // ),
                        //   height: 400.h,
                        //   width: 400.w,
                        // ));
                        //
                        // GlobalKey<NotePainterState> s3 = GlobalKey();
                        // m["14"] = s3;
                        // widgetList.add(NotePainter(
                        //   key: s3,
                        //   offset: Offset(50.w, 100.h), w: Container(
                        //   child: Text("和规范化规范化规范化风格化法国大华股份风格的和风格的和发个恢复供电和法规和风格和风格和风格和风格和规范化的恢复供电和房东改恢复供电和"),
                        // ),
                        //   height: 100.h,
                        //   width: 400.w,
                        // ));

                        setState(() {

                        });
                      },
                      child: Text("添加插件",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                      onTap: () {
                        m.forEach((key, value) {
                          if (value.currentState != null) {
                            if (!value.currentState!.remove) {
                              value.currentState?.onRemove();
                            }
                          }
                        });
                      },
                      child: Text("移除插件",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: GestureDetector(
            onTap: (){
              m.forEach((key, value) {
                if (value.currentState != null) {
                    value.currentState?.onHidden();
                }
              });
            },
            child: Container(
                margin: EdgeInsets.only(
                    top: 20.h, bottom: 40.h, left: 20.w, right: 20.w),
                height: ScreenUtil().screenHeight - 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  image: DecorationImage(image: Image.asset("assets/images/note/a_10.png").image,fit: BoxFit.fill)
                ),
                child: Stack(
                  children:[
                    ...widgetList,
                    GestureDetector(
                      onDoubleTap: (){
                        m.forEach((key, value) {
                          if (value.currentState != null) {
                            value.currentState?.onHidden();
                          }
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 20.h, bottom: 40.h, left: 20.w, right: 20.w),
                          height: ScreenUtil().screenHeight - 100.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.w)),
                              image: DecorationImage(image: Image.asset("assets/images/note/a_10.png").image,fit: BoxFit.fill)
                          ),

                      ),
                    ),
                  ]
                )
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    return widgetList;
  }
}

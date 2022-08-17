import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_note/pages/hand/widget/note_painter.dart';
import 'package:flutter_note/pages/hand/widget/transform_demo4.dart';
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

                        //GlobalKey<NotePainterState> s2 = GlobalKey();
                        //m["s2"] = s2;
                        // widgetList.add(
                        //     NotePainter(offset: Offset(200.w, 100.h), w:
                        //      Image.asset("assets/images/note/c11.png",fit: BoxFit.fill,),
                        //       height: 250.h,
                        //       width: 250.w,
                        //       rotation: 0.5,
                        //       scale: 0.1,
                        //       maxScale: 0.6,
                        //
                        //     ));
                        //GlobalKey<NotePainterState> s3 = GlobalKey();
                       // m["s3"] = s3;
                       //  widgetList.add(
                       //      NotePainter(offset: Offset(200.w, 500.h), w:
                       //      Image.asset("assets/images/note/b40.png",fit: BoxFit.fill,),
                       //        height: 250.h,
                       //        width: 250.w,
                       //        rotation: 0.8,
                       //        scale: 0.2,
                       //        maxScale: 0.7,
                       //        rote: 1,
                       //      ));
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
                        //   offset: Offset(50.w, 100.h), w: Container(
                        //   alignment: Alignment.center,
                        //   child: Container(
                        //     width: 400.w,
                        //     child: Text(
                        //         "和规范化规范化规范化风格化法国大华股份风格的和风格的和发个恢复供电和法规和风格和风格和风格和风格和规范化的恢复供电和房东改恢复供电和",
                        //            overflow: TextOverflow.ellipsis,
                        //         maxLines: 8,
                        //     ),
                        //   ),
                        // ),
                        //   height: 200.h,
                        //   width: 400.w,
                        //   rotation: 0.0,
                        //   scale: 0.5,
                        //   maxScale: 2.0,
                        //   rote: 0,
                        // ));
                        widgetList.add(TransformDemo4(child: Image.asset("assets/images/note/c11.png",fit: BoxFit.fill,),));
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
                        widgetList.clear();
                        setState(() {

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
          body: Container(
            // onTap: (){
            //   m.forEach((key, value) {
            //     if (value.currentState != null) {
            //         value.currentState?.onHidden();
            //     }
            //   });
            // },
            child: Container(
                margin: EdgeInsets.only(
                    top: 20.h, bottom: 40.h, left: 20.w, right: 20.w),
                height: ScreenUtil().screenHeight - 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                 // image: DecorationImage(image: Image.asset("assets/images/note/a_10.png").image,fit: BoxFit.fill)
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children:[

                    Positioned(
                      // onDoubleTap: (){
                      //   m.forEach((key, value) {
                      //     if (value.currentState != null) {
                      //       value.currentState?.onHidden();
                      //     }
                      //   });
                      // },
                      child: Container(
                          margin: EdgeInsets.only(
                              top: 0.h, bottom: 0.h, left: 0.w, right: 0.w),
                          height: ScreenUtil().screenHeight - 0.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20.w)),
                              image: DecorationImage(image: Image.asset("assets/images/note/a_10.png").image,fit: BoxFit.fill)
                          ),

                      ),
                    ),
                    ...widgetList,
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

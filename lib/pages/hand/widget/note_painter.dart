import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/dot_borad/dotted_border.dart';

class NotePainter extends StatefulWidget {
  const NotePainter({Key? key, this.offset, required this.w,  this.width,  this.height}) : super(key: key);
  final Offset? offset;
  final double? width;
  final double? height;
  final Widget w;
  @override
  State<NotePainter> createState() => NotePainterState();
}

class NotePainterState extends State<NotePainter> {
  Offset offset = Offset(200.w, 200.h);
  double width = 200.h;
  double height = 200.h;
  OverlayEntry? overlayEntry;
  bool remove = false;
  bool hidden =false;
  double _rotation = 0.0;
  double _baseRotation = 0.0;
  onRemove() {
    overlayEntry?.remove();
    remove = true;
  }
  onHidden() {
    hidden = false;
    overlayEntry?.markNeedsBuild();
  }
  onAdd() {
    _showFloating();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showFloating();
    });
    if (widget.offset != null) {
      offset = widget.offset!;
    }
    if (widget.width != null) {
      width = widget.width!;
    }
    if (widget.height != null) {
      height = widget.height!;
    }
    super.initState();
  }

  _showFloating() {
    var overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Stack(
        children: <Widget>[
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: _buildFloating(overlayEntry!, buildFlower(overlayEntry!)),
          ),
        ],
      );
    });
    overlayState?.insert(overlayEntry!);
  }

  Widget buildFlower(
    OverlayEntry overlayEntry,
  ) {
    return Transform.rotate(
      angle:_rotation ,
      child:Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        // borderRadius: BorderRadius.all(Radius.circular(height / 2))
      ),
      child:  Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: Opacity(
                opacity: 1.0,
                child: Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  width: width-60.w,
                  height: height-60.h,
                  child: hidden ? DottedBorder(
                    strokeWidth: 2.w,
                      dashPattern: [8, 4],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(6.w),
                      padding: EdgeInsets.all(12.w),
                      child: widget.w
                  ):widget.w,
                ),
              ),
            ),
            Positioned(
              top: 20.h,
              right: 20.w,
              child: hidden ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    print("object");
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    height = height - details.delta.dy;
                    width = width + details.delta.dx;
                    if (height < 150){
                      height=150;
                    }
                    if (width < 150){
                      width =150;
                    }
                    //print(details.delta);
                    overlayEntry.markNeedsBuild();
                      Offset centerOfGestureDetector = Offset(
                          ScreenUtil().screenWidth / 2, ScreenUtil().screenHeight / 2);
                      final touchPositionFromCenter =
                          details.localPosition - centerOfGestureDetector;
                      setState(() {
                        _rotation =
                            touchPositionFromCenter.direction- _baseRotation;
                      });
                  },
                  onPanStart: (details) {
                    Offset centerOfGestureDetector = Offset(
                        ScreenUtil().screenWidth / 2, ScreenUtil().screenHeight / 2);
                    final touchPositionFromCenter =
                        details.localPosition - centerOfGestureDetector;
                    _baseRotation =
                        touchPositionFromCenter.direction - _rotation;
                  },
                  // onPanUpdate: (details) {
                  //
                  //   Offset centerOfGestureDetector = Offset(
                  //       ScreenUtil().screenWidth / 2, ScreenUtil().screenHeight / 2);
                  //   final touchPositionFromCenter =
                  //       details.localPosition - centerOfGestureDetector;
                  //   setState(() {
                  //     _rotation =
                  //         touchPositionFromCenter.direction - _baseRotation;
                  //   });

                  //},
                  child: Container(
                   // color: Colors.yellow,
                    child: Icon(
                      Icons.ac_unit,
                      size: 50.w,
                    ),
                  )):Container(),
            ),
            Positioned(
              top: 20.h,
              left: 20.w,
              child: hidden ?GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    overlayEntry.remove();
                    remove = true;
                  },
                  child: Container(
                    //color: Colors.yellow,
                    child: Icon(
                      Icons.dark_mode,
                      size: 50.w,
                    ),
                  )):Container(),
            ),
            // Positioned(
            //   bottom: 20.h,
            //   right: 20.w,
            //   child: hidden ?GestureDetector(
            //       behavior: HitTestBehavior.opaque,
            //       onScaleStart: (_){
            //         _baseRotation = _rotation;
            //       },
            //       onScaleUpdate: (ScaleUpdateDetails e){
            //         setState((){
            //            if(e.rotation != 0){
            //              _rotation = _baseRotation + e.rotation;//选转量
            //            }
            //         });
            //       },
            //       child: Container(
            //         //color: Colors.yellow,
            //         child: Icon(
            //           Icons.dark_mode,
            //           size: 100.w,
            //         ),
            //       )):Container(),
            // ),

          ],
        ),
      ),
    );
  }

  /// 绘制悬浮控件
  _buildFloating(OverlayEntry overlayEntry, Widget c) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onPanDown: (details) {
        //offset = details.globalPosition - Offset(height / 2, height / 2);
        hidden = true;
        overlayEntry.markNeedsBuild();
      },
      onPanUpdate: (DragUpdateDetails details) {
        offset = offset + details.delta;
       // print(offset);
        overlayEntry.markNeedsBuild();
      },
      onLongPress: () {},
      child: Material(color: Colors.transparent, child: c),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
    );
  }
}

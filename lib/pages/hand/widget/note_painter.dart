import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class NotePainter extends StatefulWidget {
  const NotePainter(
      {Key? key,
      this.offset,
      required this.w,
      this.width,
      this.height,
      this.rotation,
      this.scale,
      this.maxScale,
      this.rote,
      })
      : super(key: key);
  final Offset? offset;
  final double? width;
  final double? height;
  final double? rotation;
  final double? scale;
  final double? maxScale;
  final Widget w;
  final double? rote;
  @override
  State<NotePainter> createState() => NotePainterState();
}

class NotePainterState extends State<NotePainter> {
  Offset offset = Offset(200.w, 200.h);
  double width = 200.w;
  double height = 200.h;
  OverlayEntry? overlayEntry;
  bool remove = false;
  bool hidden = false;
  double _rotation = 0;
  double _scale = 1.0;
  double _currentScale = 1.0;
  double _maxScale = 0.5;
  double _baseRotation = 0.0;
  double gWidth = 600.w;
  double gHeight = 600.h;
  double _rote =0;
  late PhotoViewController p;

  onRemove() {
    //overlayEntry?.remove();
    remove = true;
    setState(() {});
  }

  onHidden() {
    hidden = false;
    // overlayEntry?.markNeedsBuild();
  }

  onAdd() {
    //_showFloating();
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showFloating();
    // });
    if (widget.offset != null) {
      offset = widget.offset!;
    }
    if (widget.width != null) {
      width = widget.width!;
      gWidth = widget.width!;
    }
    if (widget.height != null) {
      height = widget.height!;
      gHeight = widget.height!;
    }
    if (widget.rotation != null) {
      _rotation = widget.rotation!;
    }
    if (widget.scale != null) {
      _scale = widget.scale!;
      //_currentScale = _scale;
    }
    if (widget.rote != null) {
      if(widget.rote  == 1){
        _rote =pi;
      }
    }
    if (widget.maxScale != null) {
      _maxScale = widget.maxScale!;
      if (_scale > _maxScale) {
        _scale = _maxScale;
      }
    }

    if (widget.rotation != null) {
      p = PhotoViewController(initialRotation: widget.rotation!);
    } else {
      p = PhotoViewController(initialRotation: 0);
    }

    super.initState();
  }

  // _showFloating() {
  //
  // }

  Widget buildFlower() {
    return Container(
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          // borderRadius: BorderRadius.all(Radius.circular(height / 2))
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: hidden,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            remove = true;
                          },
                          child: Container(
                            //color: Colors.yellow,
                            child: Icon(
                              Icons.dark_mode,
                              size: 80.w,
                            ),
                          )),
                    ),
                  ),
                  Container(
                    child: Visibility(
                      visible: hidden,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            print("object");
                          },
                          onPanUpdate: (DragUpdateDetails details) {
                            height = height + details.delta.dy;
                            width = width + details.delta.dx;
                            if (height < 150) {
                              height = 150;
                            }
                            if (width < 150) {
                              width = 150;
                            }
                            if (height > 300) {
                              height = 300;
                            }
                            if (width > 300) {
                              width = 300;
                            }

                            //print(details.delta);

                            Offset centerOfGestureDetector = Offset(
                                ScreenUtil().screenWidth / 2,
                                ScreenUtil().screenHeight / 2);
                            final touchPositionFromCenter =
                                details.localPosition - centerOfGestureDetector;
                            setState(() {
                              _rotation = touchPositionFromCenter.direction -
                                  _baseRotation;
                            });
                          },
                          onPanStart: (details) {
                            Offset centerOfGestureDetector = Offset(
                                ScreenUtil().screenWidth / 2,
                                ScreenUtil().screenHeight / 2);
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
                              size: 120.w,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            //   child: Opacity(
            //     opacity: 1.0,
            //     child: Container(
            //       color: Colors.green,
            //       margin: EdgeInsets.only(left: 20.w, right: 20.w),
            //       padding: EdgeInsets.only(left: 10.w, right: 10.w),
            //       width: width - 160.w,
            //       height: height - 160.h,
            //       child: hidden
            //           ? DottedBorder(
            //               strokeWidth: 2.w,
            //               dashPattern: [8, 4],
            //               borderType: BorderType.RRect,
            //               radius: Radius.circular(6.w),
            //               padding: EdgeInsets.all(12.w),
            //               child: Container(
            //                   width: width - 160.w,
            //                   height: height - 160.h,
            //                   child: widget.w))
            //           : widget.w,
            //     ),
            //   ),
            // ),
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
  _buildFloating() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (details) {
        //offset = details.globalPosition - Offset(height / 2, height / 2);
        hidden = true;
        setState(() {});
      },
      onPanUpdate: (DragUpdateDetails details) {
        offset = offset + details.delta;
        // print(offset);
        setState(() {});
      },
      onLongPress: () {
        print("onLongPress");
      },
      child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(_rote),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(gHeight/2)),
              // image: DecorationImage(image: Image.asset("assets/images/note/a_10.png").image,fit: BoxFit.fill)
            ),
            width: gWidth,
            height: gHeight,
            child: OverflowBox(
              maxWidth: 800.w,
              maxHeight: 800.h,
              child: PhotoViewGallery.builder(
                allowImplicitScrolling: true,
                //customSize: Size(gWidth, gHeight),
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                enableRotation: true,
                gaplessPlayback: true,
                backgroundDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                builder: _buildPageOptions,
                scaleStateChangedCallback: _onScaleStateChanged,
              ),
            ),
          )),
    );
  }

  PhotoViewGalleryPageOptions _buildPageOptions(
      BuildContext context, int index) {
    return PhotoViewGalleryPageOptions.customChild(
        child: widget.w,
        initialScale: _scale,
        maxScale: _maxScale,
        basePosition: Alignment.center,
        tightMode: true,
        gestureDetectorBehavior: HitTestBehavior.translucent,
        onScaleEnd: _onScaleEnd,
        controller: p);
  }

  _onScaleEnd(
    BuildContext context,
    ScaleEndDetails details,
    PhotoViewControllerValue controllerValue,
  ) {
    //print(details);
    print(controllerValue);
  }

  _onScaleStateChanged(PhotoViewScaleState scaleState) {
    print(scaleState);
    double navBarOffsetPixels;
    double bottomOffsetPixels;
    switch (scaleState) {
      case PhotoViewScaleState.covering:
      case PhotoViewScaleState.originalSize:
      case PhotoViewScaleState.zoomedIn:
        // navBarOffsetPixels = -_computeBarHeight(_navigationBarKey);
        //bottomOffsetPixels = -_computeBarHeight(_bottomBarKey);

        break;
      case PhotoViewScaleState.initial:
        _currentScale = 1.0;

        setState(() {});
        break;
      case PhotoViewScaleState.zoomedOut:
      default:
        navBarOffsetPixels = 0;
        bottomOffsetPixels = 0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return !remove
        ? Positioned(
            left: offset.dx,
            top: offset.dy,
            child: _buildFloating(),
          )
        : Positioned(child: Container());
  }
}

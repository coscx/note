import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/dot_borad/dotted_border.dart';
import 'matrix_gesture_detector.dart';

class TransformDemo4 extends StatefulWidget {
  final Widget child;

  const TransformDemo4({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransformDemo4State();
}

class TransformDemo4State extends State<TransformDemo4>
    with TickerProviderStateMixin {
  ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());
  bool? shouldScale = true;
  bool? shouldRotate = true;
  Offset centerDot = Offset(0, 0);
  late AnimationController controller;

  Alignment? focalPoint = Alignment.center;

  Animation<Alignment>? focalPointAnimation;
  List items = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ]
      .map(
        (alignment) => DropdownMenuItem<Alignment>(
          value: alignment,
          child: Text(
            alignment.toString(),
          ),
        ),
      )
      .toList();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    focalPointAnimation = makeFocalPointAnimation(focalPoint, focalPoint);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Column(
        children: makeMainWidget(getBody()),
      ),
    );
  }

  Body getBody() {
    String lbl = 'use your fingers to ';
    if (shouldRotate! && shouldScale!)
      return Body(lbl + 'rotate / scale', Icons.crop_rotate, Color(0x6600aa00));
    if (shouldRotate!)
      return Body(lbl + 'rotate', Icons.crop_rotate, Color(0x6600aa00));
    if (shouldScale!)
      return Body(lbl + 'scale', Icons.transform, Color(0x660000aa));
    return Body('you have to select at least one checkbox above', Icons.warning,
        Color(0x66aa0000));
  }

  Animation<Alignment> makeFocalPointAnimation(
      Alignment? begin, Alignment? end) {
    return controller.drive(AlignmentTween(begin: begin, end: end));
  }

  List<Widget> makeControls() => [
        ListTile(
          title: Text('focal point'),
          trailing: DropdownButton(
            onChanged: (dynamic value) {
              setState(() {
                focalPointAnimation =
                    makeFocalPointAnimation(focalPointAnimation!.value, value);
                focalPoint = value;
                controller.forward(from: 0.0);
              });
            },
            value: focalPoint,
            items: items as List<DropdownMenuItem<dynamic>>?,
          ),
        ),
        CheckboxListTile(
          value: shouldScale,
          onChanged: (bool? value) {
            setState(() {
              shouldScale = value;
            });
          },
          title: Text('scale'),
        ),
        CheckboxListTile(
          value: shouldRotate,
          onChanged: (bool? value) {
            setState(() {
              shouldRotate = value;
            });
          },
          title: Text('rotate'),
        ),
      ];

  List<Widget> makeMainWidget(Body body) => [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: MatrixGestureDetector(
                onMatrixUpdate: (m, tm, sm, rm) {
                  notifier.value = m;
                  // centerDot = centerDot +
                  //     Offset(tm.getTranslation().x, tm.getTranslation().y);
                  // setState(() {});
                },
                shouldTranslate: true,
                shouldScale: shouldScale!,
                shouldRotate: shouldRotate!,
                focalPointAlignment: focalPoint!,
                clipChild: false,
                child: AnimatedBuilder(
                  animation: notifier,
                  builder: (ctx, child) => makeTransform(ctx, child, body),
                )),
          ),
        )
      ];

  Widget makeTransform(BuildContext context, Widget? child, Body body) {
    return Transform(
      transform: notifier.value,
      child: CustomPaint(
          //foregroundPainter: FocalPointPainter(focalPointAnimation, centerDot),
          child: Container(
        color: Colors.transparent,
        child: DottedBorder(
          strokeWidth: 2.w,
          dashPattern: [8, 4],
          borderType: BorderType.RRect,
          radius: Radius.circular(6.w),
          padding: EdgeInsets.all(12.w),
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
              alignment: focalPoint!,
            ),
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.ease,
            child: Container(
              child: Stack(
                key: ValueKey('$shouldRotate-$shouldScale'),
                fit: StackFit.loose,
                children: <Widget>[
                  widget.child
                  // FittedBox(
                  //   child: Icon(
                  //     body.icon,
                  //     color: body.color,
                  //   ),
                  // ),
                  // Container(
                  //   alignment: Alignment(0, -0.5),
                  //   child: Text(
                  //     body.label,
                  //     style: Theme.of(context).textTheme.bodyText1,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class Body {
  String label;
  IconData icon;
  Color color;

  Body(this.label, this.icon, this.color);
}

class FocalPointPainter extends CustomPainter {
  Animation<Alignment>? focalPointAnimation;
  Offset? centerDot;
  Path? cross;
  late Paint foregroundPaint;

  FocalPointPainter(this.focalPointAnimation, this.centerDot)
      : super(repaint: focalPointAnimation) {
    foregroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6
      ..color = Colors.white70;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (cross == null) {
      initCross(size);
    }

    Offset translation = focalPointAnimation!.value.alongSize(size);
    //if (centerDot != null) translation = centerDot!;
    canvas.translate(translation.dx, translation.dy);
    canvas.drawPath(cross!, foregroundPaint);
  }

  @override
  bool hitTest(Offset position) => true;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void initCross(Size size) {
    var s = size.shortestSide / 8;
    cross = Path()
      ..moveTo(-s, 0)
      ..relativeLineTo(s * 0.75, 0)
      ..moveTo(s, 0)
      ..relativeLineTo(-s * 0.75, 0)
      ..moveTo(0, s)
      ..relativeLineTo(0, -s * 0.75)
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: s * 0.85));
  }
}

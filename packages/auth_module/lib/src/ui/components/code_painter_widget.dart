import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CodePainterWidget extends CustomPainter {
  final Color borderColor;

  CodePainterWidget({super.repaint, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    double w = 44;
    double h = 48;
    double r = 8;

    Paint borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    Paint gapPaint =
        Paint()
          ..color = AppColors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path rightGap =
        Path()
          ..moveTo(40, 25)
          ..arcToPoint(Offset(w, 18));

    canvas.drawRRect(fullRect, borderPaint);
    canvas.drawPath(rightGap, gapPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

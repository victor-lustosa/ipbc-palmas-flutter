import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CustomBorder extends StatelessWidget {
  final bool filled;

  const CustomBorder({super.key, required this.filled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 50,
      child: CustomPaint(
        painter: MyPainter(filled: filled),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final bool filled;
  MyPainter({super.repaint, required this.filled});

  @override
  void paint(Canvas canvas, Size size) {
    double w = 44;
    double h = 48;
    double r = 12; 

    Paint borderPaint = Paint()
      ..color = filled ? AppColors.grey6 : AppColors.darkGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Paint gapPaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path rightGap = Path()
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

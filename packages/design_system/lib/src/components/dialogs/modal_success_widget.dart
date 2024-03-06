import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ModalSuccessIconWidget extends StatelessWidget {
  const ModalSuccessIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(50, 50),
        painter: SuccessIconPainter(),
      ),
    );
  }
}

class SuccessIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = AppColors.greenInputAccept
      ..style = PaintingStyle.fill;

    final Paint checkPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Desenha o círculo
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      circlePaint,
    );

    // Desenha a marca de seleção (checkmark)
    Path path = Path()
      ..moveTo(size.width / 4, size.height / 2)
      ..lineTo(size.width * 0.4, size.height * 0.7)
      ..lineTo(size.width * 0.75, size.height * 0.3);

    canvas.drawPath(path, checkPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

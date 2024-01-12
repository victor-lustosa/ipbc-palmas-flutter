import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CircleWithX extends StatelessWidget {
  const CircleWithX({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(50, 50), // Tamanho do círculo
        painter: CircleWithXPainter(),
      ),
    );
  }
}

class CircleWithXPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint circlePaint = Paint()
      ..color = AppColors.redCircleModal
      ..style = PaintingStyle.fill;

    final Paint xPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

    // Desenha o círculo
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    // Tamanho do "X" (ajuste conforme necessário)
    double xLength = size.width / 3.5;

    // Desenha a linha diagonal da esquerda para a direita
    canvas.drawLine(
      Offset(size.width / 2 - xLength / 2, size.height / 2 - xLength / 2),
      Offset(size.width / 2 + xLength / 2, size.height / 2 + xLength / 2),
      xPaint,
    );

    // Desenha a linha diagonal da direita para a esquerda
    canvas.drawLine(
      Offset(size.width / 2 + xLength / 2, size.height / 2 - xLength / 2),
      Offset(size.width / 2 - xLength / 2, size.height / 2 + xLength / 2),
      xPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';

class Xmodal extends StatelessWidget {
  const Xmodal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(30, 30), // Tamanho do círculo
        painter: CircleWithXPainter(),
      ),
    );
  }
}

class CircleWithXPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint xPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;

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

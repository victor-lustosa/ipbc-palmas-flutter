import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

enum DialogType { success, error }

Future<void> showCustomMessageDialog({
  required BuildContext context,
  required String title,
  required String message,
  Function()? onClose,
  required DialogType type,
}) async {
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Toast',
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (buildContext, animation, secondaryAnimation) {
      if(onClose == null){
        Future.delayed(Duration(milliseconds: 800), (){
          if(context.mounted){
            nativePop(context);
          }
        });
      }
      return ErrorDialogWidget(
        title: title,
        message: message,
        onClose: onClose,
        type: type,
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
          child: child,
        ),
      );
    },
  );
}

class ErrorDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onClose;
  final DialogType type;

  const ErrorDialogWidget({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {

    late final Color backgroundColor;
    late final Widget icon;

    switch (type) {
      case DialogType.success:
        backgroundColor = AppColors.darkGreen;
        icon = const SuccessIconWidget();
        break;
      case DialogType.error:
        backgroundColor = AppColors.redModal;
        icon = const ErrorIconWidget();
        break;
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40, left: 16, right: 16),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Container(
            width: context.sizeOf.width,
            constraints: const BoxConstraints(minHeight: 95),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          icon,
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  title,
                                  style: AppFonts.defaultFont(
                                    fontSize: 16,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  message,
                                  style: AppFonts.defaultFont(
                                    fontSize: 12,
                                    color: AppColors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          if (onClose != null) {
                            onClose!();
                          }
                        },
                        child: Image.asset(
                          AppIcons.close,
                          width: 14,
                          height: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorIconWidget extends StatelessWidget {
  const ErrorIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: const Size(50, 50),
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
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      circlePaint,
    );

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

class SuccessIconWidget extends StatelessWidget {
  const SuccessIconWidget({super.key});

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

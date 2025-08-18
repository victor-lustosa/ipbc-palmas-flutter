import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class SuccessDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onClose;

  const SuccessDialogWidget({
    super.key,
    required this.title,
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.none,
      insetPadding: const EdgeInsets.all(3),
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: AppColors.darkGreen,
      content: IntrinsicHeight(
        child: Row(
          children: [
            const ModalSuccessIconWidget(),
            //const CircleWithX(),
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
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    nativePop(context);
                    if (onClose != null) {
                      onClose!();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Image.asset(AppIcons.close, width: 10, height: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomSuccessDialog({
  required BuildContext context,
  required String title,
  required String message,
  Function()? onClose,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      if(onClose == null){
        Future.delayed(Duration(seconds: 1), (){
          if(context.mounted){
            nativePop(context);
          }
        });
      }
      return Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 13,
            right: 13,
            child: SuccessDialogWidget(
              title: title,
              message: message,
              onClose: onClose,
            ),
          ),
        ],
      );
    },
  );
}


class ModalSuccessIconWidget extends StatelessWidget {
  const ModalSuccessIconWidget({super.key});

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
    final Paint circlePaint =
    Paint()
      ..color = AppColors.greenInputAccept
      ..style = PaintingStyle.fill;

    final Paint checkPaint =
    Paint()
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
    Path path =
    Path()
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

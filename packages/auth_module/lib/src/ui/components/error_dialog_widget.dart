import 'package:auth_module/src/ui/components/modal_close_button_widget.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onClose;

  const ErrorDialogWidget({
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
      backgroundColor: AppColors.redModal,
      content: IntrinsicHeight(
        child: Row(
          children: [
            const ModalCloseButtonWidget(),
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
                    Navigator.of(context).pop();
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
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomErrorDialog(
    BuildContext context, String title, String message,
    {Function()? onClose}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 13,
            right: 13,
            child: ErrorDialogWidget(
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

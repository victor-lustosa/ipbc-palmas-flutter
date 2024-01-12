import 'package:auth_module/src/ui/components/circle_modal.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import 'x_modal.dart';

class CustomErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onClose;

  const CustomErrorDialog({
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
            const CircleWithX(),
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onClose != null) {
                      onClose!();
                    }
                  },
                  style: ButtonStyle(
                    alignment: Alignment.topRight,
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  child: const Xmodal(),
                ),
              ],
            ),
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
            child: CustomErrorDialog(
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

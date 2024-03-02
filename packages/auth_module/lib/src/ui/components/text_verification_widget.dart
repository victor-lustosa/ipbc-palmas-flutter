import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextVerificationWidget extends StatelessWidget {
  final String textOne;
  final TextStyle? styleOne;
  final String? textTwo;
  final TextStyle? styleTwo;
  final VoidCallback? onTapTextTwo;

  const TextVerificationWidget({
    Key? key,
    required this.textOne,
    this.styleOne,
    this.textTwo,
    this.styleTwo,
    this.onTapTextTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: textOne,
            style: styleOne ??
                AppFonts.defaultFont(
                  color: AppColors.grey8,
                  fontSize: 15,
                ),
          ),
          if (textTwo != null && styleTwo != null)
            TextSpan(
              text: textTwo,
              style: styleTwo,
              recognizer: onTapTextTwo != null
                  ? (TapGestureRecognizer()..onTap = onTapTextTwo)
                  : null,
            ),
        ],
      ),
    );
  }
}

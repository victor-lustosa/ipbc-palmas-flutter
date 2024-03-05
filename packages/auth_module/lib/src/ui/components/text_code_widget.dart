import 'package:auth_module/src/ui/components/custom_border_widget.dart';
import 'package:auth_module/src/ui/view_models/password_view_model.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TextCodeWidget extends StatefulWidget {
  const TextCodeWidget({Key? key}) : super(key: key);

  @override
  State<TextCodeWidget> createState() => _TextCodeWidgetState();
}

class _TextCodeWidgetState extends State<TextCodeWidget> {
  final codeController = Modular.get<PasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width,
      // height: 150,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              6,
              (index) => Row(
                children: [
                  Stack(
                    children: [
                      CustomBorderWidget(
                          filled:
                              codeController.controllers[index].text.isEmpty),
                      SizedBox(
                        width: 48,
                        height: 50,
                        child: TextField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          focusNode: codeController.focusNodes[index],
                          controller: codeController.controllers[index],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                if (index > 0) {
                                  codeController.focusNodes[index - 1]
                                      .requestFocus();
                                }
                              } else if (index <
                                  codeController.focusNodes.length - 1) {
                                codeController.focusNodes[index + 1]
                                    .requestFocus();
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.all(10),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelStyle: TextStyle(color: AppColors.darkGreen),
                          ),
                          cursorColor: AppColors.darkGreen,
                          cursorWidth: 1.5,
                          style: const TextStyle(color: AppColors.darkGreen),
                        ),
                      ),
                    ],
                  ),
                  if (index < 5) const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in codeController.controllers) {
      controller.text = '';
    }
    super.dispose();
  }
}

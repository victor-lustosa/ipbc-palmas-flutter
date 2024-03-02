import 'package:auth_module/src/ui/components/custom_border_widget.dart';
import 'package:auth_module/src/ui/controller/code_controller.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TextfieldCodeNumbers extends StatefulWidget {
  const TextfieldCodeNumbers({Key? key}) : super(key: key);

  @override
  State<TextfieldCodeNumbers> createState() => _TextfieldCodeNumbersState();
}

class _TextfieldCodeNumbersState extends State<TextfieldCodeNumbers> {
  final codeController = Modular.get<CodeController>();
  List<String> textFieldValues = [];
  final List<TextEditingController> textController =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var focusNode in codeController.focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width,
      height: 150,
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
                      CustomBorder(
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
                            textFieldValues = codeController.controllers
                                .map((controller) => controller.text)
                                .toList();
                            setState(() {
                              if (value.isEmpty) {
                                if (index > 0) {
                                  codeController.focusNodes[index - 1]
                                      .requestFocus();
                                }
                              } else if (index < codeController.focusNodes.length - 1) {
                                codeController.focusNodes[index + 1]
                                    .requestFocus();
                              }
                              if (value.isEmpty) {
                                codeController.textingCode = '';
                              } else {
                                codeController.textingCode = textFieldValues.join();
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
}

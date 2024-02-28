import 'dart:developer';

import 'package:auth_module/src/ui/components/banner_error.dart';
import 'package:auth_module/src/ui/components/custom_border_widget.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TextfieldCodeNumbers extends StatefulWidget {
  const TextfieldCodeNumbers({Key? key}) : super(key: key);

  @override
  State<TextfieldCodeNumbers> createState() => _TextfieldCodeNumbersState();
}

class _TextfieldCodeNumbersState extends State<TextfieldCodeNumbers> {
  final List<int> code = [1, 2, 3, 4, 5, 6]; // Code Mockado;

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> textFieldValues =
        controllers.map((controller) => controller.text).toList();

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
                      CustomBorder(filled: controllers[index].text.isEmpty),
                      SizedBox(
                        width: 48,
                        height: 50,
                        child: TextField(
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          focusNode: _focusNodes[index],
                          controller: controllers[index],
                          onChanged: (value) {
                            if (value.isEmpty) {
                              if (index > 0) {
                                _focusNodes[index - 1].requestFocus();
                              }
                            } else if (index < _focusNodes.length - 1) {
                              _focusNodes[index + 1].requestFocus();
                            }
                            setState(() {});
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
          Container(
            margin: const EdgeInsets.only(
              top: 16,
            ),
            child: ElevatedButtonWidget(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              fixedSize: const Size(343, 48),
              action: () {
                if (textFieldValues.every((value) => value.isNotEmpty)) {
                  log('TODOS OS Valores dos TextFields preechidos: $textFieldValues');

                  if (textFieldValues.join() == code.join()) {
                    Navigator.pushNamed(
                      context,
                      AuthModule.initialRoute +
                          AuthModule.creatingNewPassWordRoute,
                    );
                  } else {
                    showCustomErrorDialog(
                      context,
                      'Código Inválido!',
                      'Por favor, preencha o verifique o código, e tente novamente.',
                    );
                  }
                } else {
                  showCustomErrorDialog(
                    context,
                    'Código não Preenchidos!',
                    'Por favor, preencha o código de verificação e tente novamente.',
                  );
                }
              },
              backgroundColor:
                  textFieldValues.every((value) => value.isNotEmpty)
                      ? AppColors.darkGreen
                      : AppColors.disableButton,
              shadowColor: AppColors.grey0,
              foregroundColor: AppColors.white,
              child: const Text(
                "Verificar",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

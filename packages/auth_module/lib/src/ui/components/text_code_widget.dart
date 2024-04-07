import 'package:auth_module/src/ui/components/code_painter_widget.dart';
import 'package:auth_module/src/ui/stores/reset_password_store.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TextCodeWidget extends StatefulWidget {
  const TextCodeWidget({Key? key}) : super(key: key);

  @override
  State<TextCodeWidget> createState() => _TextCodeWidgetState();
}

class _TextCodeWidgetState extends State<TextCodeWidget> {
  final _store = Modular.get<ResetPasswordStore>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (_, context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 12,
              ),
              width: 44,
              height: 48,
              child: CustomPaint(
                painter: CodePainterWidget(
                  borderColor: _store.isError
                      ? AppColors.codeBorderError
                      : _store.controllers[index].text.isEmpty
                          ? AppColors.grey6
                          : AppColors.darkGreen,
                ),
                child: TextField(
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  focusNode: _store.focusNodes[index],
                  controller: _store.controllers[index],
                  onChanged: (value) {
                    setState(
                      () {
                        _store.focusControl(value: value, index: index);
                        _store.colorBorder();
                        _store.emptyBorder();
                      },
                    );
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 2.5,
                      bottom: 4,
                    ),
                    counterText: '',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  cursorColor: _store.isError
                      ? AppColors.codeBorderError
                      : _store.controllers[index].text.isEmpty
                          ? AppColors.hintInputForm
                          : AppColors.darkGreen,
                  cursorWidth: 1.5,
                  style: AppFonts.defaultFont(
                    color: _store.isError
                        ? AppColors.codeBorderError
                        : AppColors.darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _store.controllers) {
      controller.text = '';
    }
    super.dispose();
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ResetPasswordStore
    extends ValueNotifier<GenericState<ResetPasswordState>> {
  ResetPasswordStore() : super(InitialState<ResetPasswordState>());

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<int> code = [1, 2, 3, 4, 5, 8]; // Code Mockado;

  List<FocusNode> get focusNodes => _focusNodes;

  List<TextEditingController> get controllers => _controllers;
  List<String> inputCode = [];

  bool isError = false;
  bool isListFull = false;

  notifyBorderError({required value}) {
    isError = value;
  }

  validateCode(BuildContext context) {
    value = LoadingState<ResetPasswordState>();
    try {
      Future.delayed(const Duration(seconds: 1), () {
        inputCode = _controllers.map((controller) => controller.text).toList();
        if (inputCode.every((value) => value.isNotEmpty)) {
          if (inputCode.join() == code.join()) {
            AppRoutes().nativePushNamed(
              AuthModule.authRoute + AuthModule.creatingNewPassWordRoute,
              context,
            );
          } else {
            notifyBorderError(value: true);
            showCustomErrorDialog(
              context: context,
              title: 'Código Inválido!',
              message: 'Por favor, verifique o código, e tente novamente.',
            );
          }
        } else {
          notifyBorderError(value: true);
          showCustomErrorDialog(
            context: context,
            title: 'Código não Preenchidos!',
            message:
                'Por favor, preencha o código de verificação e tente novamente.',
          );
        }
        value = InitialState<ResetPasswordState>();
      });
    } catch (e) {
      value = InitialState<ResetPasswordState>();
    }
  }

  colorBorder() {
    isListFull = _controllers.where((e) => e.text != '').toList().length > 5
        ? true
        : false;
    notifyListeners();
  }

  emptyBorder() {
    if (_controllers.where((e) => e.text != '').toList().isEmpty) {
      notifyBorderError(value: false);
      notifyListeners();
    }
  }

  focusControl({required String value, required int index}) {
    if (value.isEmpty) {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    } else if (index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    }
  }
}

@immutable
abstract class ResetPasswordState {}

@immutable
abstract class ValidateFieldsState extends GenericState<ResetPasswordState> {}

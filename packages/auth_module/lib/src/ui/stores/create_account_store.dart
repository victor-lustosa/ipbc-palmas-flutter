import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountStore
    extends ValueNotifier<GenericState<CreateAccountState>> {
  CreateAccountStore() : super(InitialState<CreateAccountState>());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  bool _arePasswordEqual = false;

  get emailController => _emailController;
  get passwordController => _passwordController;
  get passwordRepeatController => _passwordRepeatController;

  get email => _emailController.text;
  get password => _passwordController.text;
  get passwordConfirm => _passwordRepeatController.text;

  bool isError = false;

  bool get emptyPasswords =>
      _passwordController.text.isEmpty &&
      _passwordRepeatController.text.isEmpty;

  bool get emptyData =>
      _passwordController.text.isNotEmpty &&
      _passwordRepeatController.text.isNotEmpty &&
      _emailController.text.isNotEmpty;

  get arePasswordEqual {
    if (emptyPasswords) {
      _arePasswordEqual = false;
    } else {
      _arePasswordEqual = password == passwordConfirm;
    }
    return _arePasswordEqual;
  }

  notifyBorderError({required value}) {
    isError = value;
  }

  validateCode(BuildContext context) {
    value = LoadingState<CreateAccountState>();
    try {
      Future.delayed(const Duration(seconds: 1), () {
        if (_arePasswordEqual && emptyData) {
          Navigator.pushNamed(
            context,
            AuthModule.authRoute + AuthModule.registrationCompletionRoute,
          );
        } else {
          notifyBorderError(value: true);
          showCustomErrorDialog(
            context: context,
            title: 'Dados Incorretos',
            message: 'Por favor, Verifique os dados e tente novamente.',
          );
        }
        value = InitialState<CreateAccountState>();
      });
    } catch (e) {
      value = InitialState<CreateAccountState>();
    }
  }
}

@immutable
abstract class CreateAccountState {}

@immutable
abstract class ValidateFieldsState extends GenericState<CreateAccountState> {}

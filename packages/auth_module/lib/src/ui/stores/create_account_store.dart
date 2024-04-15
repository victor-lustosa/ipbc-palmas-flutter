import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountStore
    extends ValueNotifier<GenericState<CreateAccountState>> {
  CreateAccountStore() : super(InitialState<CreateAccountState>());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  get emailController => _emailController;
  get passwordController => _passwordController;
  get passwordRepeatController => _passwordRepeatController;

  get email => _emailController.text;
  get password => _passwordController.text;
  get passwordConfirm => _passwordRepeatController.text;

  bool isError = false;

  bool get emptyEmail => _emailController.text.isEmpty;

  get isPasswordLengthValid => _passwordController.text.length > 7;

  bool get emptyPasswords =>
      _passwordController.text.isEmpty &&
      _passwordRepeatController.text.isEmpty;

  bool get emptyData =>
      _passwordController.text.isNotEmpty &&
      _passwordRepeatController.text.isNotEmpty &&
      _emailController.text.isNotEmpty;

  bool get isPasswordEqual =>
      emptyPasswords ? false : password == passwordConfirm;

  notifyBorderError({required value}) {
    isError = value;
  }

  validateCode(BuildContext context) {
    value = LoadingState<CreateAccountState>();
    Future.delayed(const Duration(seconds: 1), () {
      if (isPasswordEqual && emptyData) {
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
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }
}

@immutable
abstract class CreateAccountState {}

@immutable
abstract class ValidateFieldsState extends GenericState<CreateAccountState> {}

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountStore
    extends ValueNotifier<GenericState<CreateAccountState>> {
  CreateAccountStore({required IAuthUseCases useCases})
    : _useCases = useCases,
      super(InitialState<CreateAccountState>());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  final IAuthUseCases _useCases;
  ValueNotifier<bool> isCreateAccountPressed = ValueNotifier(false);
  ValueNotifier<bool> isGoogleLoginPressed = ValueNotifier(false);
  ValueNotifier<bool> firstObscure = ValueNotifier(true);
  ValueNotifier<bool> secondObscure = ValueNotifier(true);
  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get passwordRepeatController =>
      _passwordRepeatController;

  String get email => _emailController.text;

  String get password => _passwordController.text;

  String get passwordConfirm => _passwordRepeatController.text;

  bool isError = false;

  bool get isPasswordLengthValid => _passwordController.text.length > 7;

  bool get emptyEmail => _emailController.text.isEmpty;

  bool get emptyPasswords =>
      _passwordController.text.isEmpty &&
      _passwordRepeatController.text.isEmpty;

  bool get emptyData =>
      _passwordController.text.isNotEmpty &&
      _passwordRepeatController.text.isNotEmpty &&
      _emailController.text.isNotEmpty;

  bool get isPasswordEqual =>
      emptyPasswords ? false : password == passwordConfirm;

  void notifyBorderError({required value}) {
    isError = value;
  }

  void createAccount(BuildContext context) async{
    isCreateAccountPressed.value = true;
    value = LoadingState<CreateAccountState>();
    final result = await _useCases.createAccount(email, password);
      if (result == 'sucesso') {
        pushNamed(AppRoutes.authRoute + AppRoutes.accountCreatedRoute);
      } else {
        notifyBorderError(value: true);
        if (context.mounted) {
          showCustomErrorDialog(
            context: context,
            title: 'Dados Incorretos',
            message: 'Por favor, Verifique os dados e tente novamente.',
          );
        }
      }
     isCreateAccountPressed.value = false;
     value = InitialState<CreateAccountState>();
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

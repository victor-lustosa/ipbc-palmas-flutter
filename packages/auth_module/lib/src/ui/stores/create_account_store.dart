import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountStore
    extends ValueNotifier<GenericState<CreateAccountState>> with ValidationMixin{
  CreateAccountStore({required IAuthUseCases useCases})
    : _useCases = useCases,
      super(InitialState<CreateAccountState>());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController = TextEditingController();

  final IAuthUseCases _useCases;

  ValueNotifier<bool> isCreateAccountPressed = ValueNotifier(false);
  ValueNotifier<bool> isGoogleLoginPressed = ValueNotifier(false);
  ValueNotifier<bool> firstObscure = ValueNotifier(true);
  ValueNotifier<bool> secondObscure = ValueNotifier(true);
  ValueNotifier<bool> emailInitState = ValueNotifier(true);
  ValueNotifier<bool> passwordInitState = ValueNotifier(true);
  ValueNotifier<bool> secondPasswordInitState = ValueNotifier(true);

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get passwordRepeatController =>
      _passwordRepeatController;

  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _repeatPasswordKey = GlobalKey<FormState>();

  GlobalKey<FormState> get emailKey => _emailKey;

  GlobalKey<FormState> get passwordKey => _passwordKey;

  GlobalKey<FormState> get repeatPasswordKey => _repeatPasswordKey;

  final String _emailErrorText = 'por favor, insira um email válido.';
  final String _passwordErrorText = 'por favor, insira uma senha.';
  final String _passwordErrorConfirmText = 'por favor, Repita a senha.';

  String get emailErrorText => _emailErrorText;

  String get passwordErrorText => _passwordErrorText;

  String get passwordErrorConfirmText => _passwordErrorConfirmText;

  ValueNotifier<bool> isEmailValid = ValueNotifier(true);
  ValueNotifier<bool> isPasswordValid = ValueNotifier(true);
  ValueNotifier<bool> isSecondPasswordValid = ValueNotifier(true);

  String get email => _emailController.text;

  String get password => _passwordController.text;

  String get passwordConfirm => _passwordRepeatController.text;

  bool get isPasswordLengthValid =>
      _passwordController.text.length > 7 &&
      _passwordRepeatController.text.length > 7;

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

  void createAccount(BuildContext context) async {
    value = LoadingState<CreateAccountState>();
    isCreateAccountPressed.value = true;
    final result = await _useCases.createAccount(email, password);
    if (result == 'sucesso') {
      pushNamed(AppRoutes.authRoute + AppRoutes.accountCreatedRoute);
    } else {
      if (context.mounted) {
        showCustomMessageDialog(
          type: DialogType.error,
          context: context,
          title: 'Dados Incorretos',
          message: 'Por favor, Verifique os dados e tente novamente.',
        );
      }
    }
    isCreateAccountPressed.value = false;
    value = InitialState<CreateAccountState>();
  }

  formValidation(bool validation, ValueNotifier<bool> isValid) {
    Future.delayed(Duration.zero, () async {
      isValid.value = validation;
      value = UpdateFormFieldState();
    });
    return null;
  }

  void clear() {
    _emailController.clear();
    _passwordController.clear();
    _passwordRepeatController.clear();
    emailInitState.value = true;
    passwordInitState.value = true;
    secondPasswordInitState.value = true;
    isEmailValid.value = true;
    isPasswordValid.value = true;
    isSecondPasswordValid.value = true;
    isCreateAccountPressed.value = false;
    firstObscure.value = true;
    secondObscure.value = true;
    value = InitialState<CreateAccountState>();
  }
}

@immutable
abstract class CreateAccountState {}

@immutable
abstract class ValidateFieldsState extends GenericState<CreateAccountState> {}

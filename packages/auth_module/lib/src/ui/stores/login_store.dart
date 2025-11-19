import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>>
    with ConnectivityMixin, ValidationMixin {
  LoginStore({
    required AuthCircleAvatarStore authCircleAvatarStore,
    required IAuthUseCases useCases,
  }) : _useCases = useCases,
       _authCircleAvatarStore = authCircleAvatarStore,
       super(InitialState<LoginState>());

  final IAuthUseCases _useCases;
  final AuthCircleAvatarStore _authCircleAvatarStore;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  GlobalKey<FormState> get emailKey => _emailKey;

  GlobalKey<FormState> get passwordKey => _passwordKey;
  final String _emailErrorText = 'por favor, insira um email válido.';
  final String _passwordErrorText = 'por favor, insira uma senha.';

  String get emailErrorText => _emailErrorText;

  String get passwordErrorText => _passwordErrorText;
  ValueNotifier<bool> isEmailValid = ValueNotifier(true);
  ValueNotifier<bool> isPasswordValid = ValueNotifier(true);
  ValueNotifier<bool> isLoginPressed = ValueNotifier(false);
  ValueNotifier<bool> areFieldsLocked = ValueNotifier(false);
  ValueNotifier<bool> isGoogleLoginPressed = ValueNotifier(false);
  ValueNotifier<bool> obscure = ValueNotifier(true);

  Future<void> logIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    value = LoadingState<LoginState>();
    isLoginPressed.value = true;
    final response = await isConnected(
      context: context,
      onDelayedAction: () {
        Future.delayed(Duration.zero, () {
          isLoginPressed.value = false;
          value = InitialState<LoginState>();
        });
      },
    );
    if (response) {
      final message = await _useCases.signInWithEmail(email, password);
      if (context.mounted) {
        if (message == null) {
          toHome(context);
        } else {
          showCustomMessageDialog(
            type: DialogType.error,
            context: context,
            title: 'Email ou senha incorretos!',
            message: message,
            duration: Duration(milliseconds: 1200),
            onDelayedAction: () {
              isLoginPressed.value = false;
              value = InitialState<LoginState>();
            },
          );
        }
      }
    }
  }

  Future<void> googleSignIn(BuildContext context) async {
    value = LoadingState<LoginState>();
    isGoogleLoginPressed.value = true;
    final token = await _useCases.signInWithGoogle();
    if (context.mounted) {
      if (token != null && token.isNotEmpty) {
        toHome(context);
      } else {
        isGoogleLoginPressed.value = false;
        value = InitialState<LoginState>();
      }
    }
  }

  /* // Login Facebook
  Future<void> signInWithFacebook() async {
    await _onlineUseCases.signInWithFacebook();
  }*/

   void formValidation(bool validation, ValueNotifier<bool> isValid) {
    Future.delayed(Duration.zero, () async {
      isValid.value = validation;
      value = UpdateFormFieldState();
    });
  }

  void toCreateAccount() {
    pushNamed(AppRoutes.authRoute + AppRoutes.createAccountRoute);
  }

  void toHome(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 200),
      () => _authCircleAvatarStore.validateAuthentication(),
    );
    if (context.mounted) {
      pop(context);
    }
  }

  Future createAccount() async {
    //_useCase.add('auth', HiveAuthDTO(token: emailController.text,));
    Future.delayed(const Duration(microseconds: 300), () {
      navigate(AppRoutes.loginRoute);
    });
  }

  Future<void> loginValidate({required BuildContext context}) async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        isEmailValid.value &&
        isPasswordValid.value &&
        !isLoginPressed.value) {
      await logIn(_emailController.text, _passwordController.text, context);
    } else {
      if(_emailController.text.isEmpty) isEmailValid.value = false;
      if(_passwordController.text.isEmpty) isPasswordValid.value = false;
      value = UpdateFormFieldState();
    }
  }
}

@immutable
abstract class LoginState {}

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>> {
  LoginStore({
    required AuthCircleAvatarStore authCircleAvatarStore,
    required IAuthUseCases useCases,
  }) : _useCases = useCases,
       _authCircleAvatarStore = authCircleAvatarStore,
       super(InitialState<LoginState>());

  final IAuthUseCases _useCases;
  final AuthCircleAvatarStore _authCircleAvatarStore;

  final String _email = 'victor.olustosa@outlook.com';
  final String _password = '!Helena2201';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  get emailController => _emailController;

  get passwordController => _passwordController;
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  get emailKey => _emailKey;

  get passwordKey => _passwordKey;
  final String _emailErrorText = 'por favor, insira um email válido.';
  final String _passwordErrorText = 'por favor, insira uma senha.';

  get emailErrorText => _emailErrorText;

  get passwordErrorText => _passwordErrorText;
  ValueNotifier<bool> isEmailValid = ValueNotifier(true);
  ValueNotifier<bool> isPasswordValid = ValueNotifier(true);
  ValueNotifier<bool> isPressed = ValueNotifier(false);
  ValueNotifier<bool> obscure = ValueNotifier(true);

  Future<void> logIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    isPressed.value = true;
    value = LoadingState<LoginState>();
    Future.delayed(const Duration(seconds: 1), () {
      if (_email == email && _password == password) {
        navigate(AppRoutes.initialRoute);
      } else {
        isPressed.value = false;
        value = InitialState<LoginState>();
        if (context.mounted) {
          showCustomErrorDialog(
            title: 'Dados Incorretos',
            message: 'Verifique se a senha e o email estão corretos.',
            context: context,
          );
        }
      }
    });

    // var email = '';
    //Stream<HiveAuthDTO> credentials = await _useCase.get('auth/${emailController.text}/${passwordController.text}');
    //  await for(final value in credentials){
    //   email = value.token;
    // }
    //await _useCases.get('auth/$email/$password');
    //if (email.isNotEmpty) {
    //   navigate('/home/',isNative:false);
    //   return '';
    //  } else {
    //   return 'login inválido';
    //}
  }

  Future<void> nativeGoogleSignIn(BuildContext context) async {
    value = LoadingState<LoginState>();
    final token = await _useCases.signInWithGoogle();
    if (context.mounted) {
      if (token != null && token.isNotEmpty) {
        toHome(context);
      } else {
        value = InitialState<LoginState>();
      }
    }
  }

  /* // Login Facebook
  Future<void> signInWithFacebook() async {
    await _onlineUseCases.signInWithFacebook();
  }*/
  formValidation(bool validation, ValueNotifier<bool> isValid) {
    changeValue(isValid, validation);
    return null;
  }

  bool isEmptyData(String? data) {
    return (data == null || data.isEmpty);
  }

  bool emailValidation(String? data) {
    return !isEmptyData(data) && EmailValidator.validate(data ?? '');
  }

  changeValue(ValueNotifier<bool> valueNotifier, bool newValue) {
    Future.delayed(Duration.zero, () async {
      valueNotifier.value = newValue;
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
        !isPressed.value) {
      if (emailValidation(_emailController.text)) {
        await logIn(_emailController.text, _passwordController.text, context);
      } else {
        changeValue(isEmailValid, false);
      }
    }
  }
}

@immutable
abstract class LoginState {}

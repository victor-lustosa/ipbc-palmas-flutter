import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

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

  Future<void> logIn(
    String email,
    String password,
    BuildContext context,
  ) async {
    value = LoadingState<LoginState>();
    Future.delayed(const Duration(seconds: 1), () {
      if (_email == email && _password == password) {
        navigate(AppRoutes.initialRoute);
      } else {
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
      if(token != null && token.isNotEmpty){
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

  void validateFields() {
    value = ValidateFieldsState();
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
}

@immutable
abstract class LoginState {}

class ValidateFieldsState extends GenericState<LoginState> {}

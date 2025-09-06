import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>> {
  LoginStore({
    required AuthCircleAvatarStore authCircleAvatarStore,
    required IOfflineAuthUseCases offlineUse,
    required IOnlineAuthUseCases onlineUse,
  }) : _offlineUseCases = offlineUse,
       _onlineUseCases = onlineUse,
       _authCircleAvatarStore = authCircleAvatarStore,

       super(InitialState<LoginState>());

  final IOfflineAuthUseCases _offlineUseCases;
  final IOnlineAuthUseCases _onlineUseCases;
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

  //Login Google
  Future<void> nativeGoogleSignIn(BuildContext context) async {
    value = LoadingState<LoginState>();
    final String? token = await _onlineUseCases.signInWithGoogle();
    final UserEntity? currentUser = _onlineUseCases.getCurrentUser();
    saveUserAndToken(currentUser, token);
    if (context.mounted) {
      token != null && token.isNotEmpty ? toHome(context) : null;
    }
  }

  Future<void> saveUserAndToken(currentUser, token) async {
    if (currentUser != null) _offlineUseCases.saveLocalUser(currentUser);
    if (token != null) _offlineUseCases.saveToken(token);
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
      navigate('/login');
    });
  }
}

@immutable
abstract class LoginState {}

class ValidateFieldsState extends GenericState<LoginState> {}

import 'package:flutter/cupertino.dart';
import 'package:home_module/home_module.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>> {
  LoginStore({
    required IOfflineAuthUseCases offlineUse,
    required IOnlineAuthUseCases onlineUse,
  }) : _offlineUseCases = offlineUse,
       _onlineUseCases = onlineUse,
       super(InitialState<LoginState>());

  final IOfflineAuthUseCases _offlineUseCases;
  final IOnlineAuthUseCases _onlineUseCases;

  final String _email = 'victor.olustosa@outlook.com';
  final String _password = '!Helena2201';

  logIn(String email, String password, BuildContext context) async {
    value = LoadingState<LoginState>();
    Future.delayed(const Duration(seconds: 1), () {
      if (_email == email && _password == password) {
        navigate(InitModule.initialRoute);
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
  Future<void> nativeGoogleSignIn() async {
    value = LoadingState<LoginState>();
    final String? token = await _onlineUseCases.signInWithGoogle();
    final UserEntity? currentUser = _onlineUseCases.getCurrentUser();
    saveUserAndToken(currentUser, token);
    token != null && token.isNotEmpty ? toHome() : null;
  }

  Future<void> saveUserAndToken(currentUser, token) async {
    if (currentUser != null) _offlineUseCases.saveLocalUser(currentUser);
    if (token != null) _offlineUseCases.saveToken(token);
  }

  Future<UserEntity> getLocalUser() async {
    return await _offlineUseCases.getLocalUser();
  }

  // Login Facebook
  Future<void> signInWithFacebook() async {
    await _onlineUseCases.signInWithFacebook();
  }

  validateFields() {
    value = ValidateFieldsState();
  }

  toCreateAccount() {
    pushNamed(AuthModule.authRoute + AuthModule.createAccountRoute);
  }

  toHome() {
    navigate(InitModule.initialRoute);
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

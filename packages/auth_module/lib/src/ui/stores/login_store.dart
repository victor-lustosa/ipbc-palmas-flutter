import 'package:flutter/cupertino.dart';
import 'package:home_module/home_module.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>> {
  LoginStore({required IOfflineAuthUseCases offlineUse, required IOnlineAuthUseCases onlineUse})
      : _offlineUse = offlineUse,
        _onlineUse = onlineUse,
        super(InitialState<LoginState>());

   final IOfflineAuthUseCases _offlineUse;
   final IOnlineAuthUseCases _onlineUse;

  final String _email = 'victor.olustosa@outlook.com';
  final String _password = '!Helena2201';
  final SupabaseClient _supaClient = Modular.get<SupabaseClient>();

  logIn(String email, String password, BuildContext context) async {
    value = LoadingState<LoginState>();
    Future.delayed(const Duration(seconds: 1), () {
      if (_email == email && _password == password) {
        navigate(InitModule.initialRoute);
      } else {
        value = InitialState<LoginState>();
        if(context.mounted){
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
    final String? accessToken = await _onlineUse.signInWithGoogle();
    //UserEntity currentUser = _onlineUse.getCurrentUser();
    accessToken != null && accessToken.isNotEmpty ? toHome() : null;
  }

  // Login Facebook
  Future<void> signInWithFacebook() async {
    await _supaClient.auth.signInWithOAuth(OAuthProvider.facebook);
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

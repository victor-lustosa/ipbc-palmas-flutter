import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_module/home_module.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>> {
  LoginStore({required IAuthUseCases useCases})
      :
        //: _useCases = useCases,
        super(InitialState<LoginState>());

  // final IAuthUseCases _useCases;

  final String _email = 'victor.olustosa@outlook.com';
  final String _password = '!Helena2201';

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
    const webClientId = ApiKeys.webCredencial;

    const iosClientId = ApiKeys.iosCredencial;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;
    final idToken = googleAuth?.idToken;

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    if (accessToken == null) {
      throw 'No Access Token found.';
    }

    accessToken.isNotEmpty ? toHome() : null;
  }

  // Login Facebook
  Future<void> signInWithFacebook() async {
    await supabase.auth.signInWithOAuth(OAuthProvider.facebook);
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

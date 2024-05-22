
import 'package:flutter/cupertino.dart';
import 'package:home_module/home_module.dart';

class LoginStore extends ValueNotifier<GenericState<LoginState>> {
  LoginStore({required IAuthUseCases useCases}):
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
        showCustomErrorDialog(
          title: 'Dados Incorretos',
          message: 'Verifique se a senha e o email estão corretos.',
          context: context,
        );
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

  validateFields() {
    value = ValidateFieldsState();
  }

  toCreateAccount() {
   pushNamed(AuthModule.authRoute + AuthModule.createAccountRoute);
  }

  Future createAccount() async {
    //_useCase.add('auth', HiveAuthDTO(token: emailController.text,));
    Future.delayed(const Duration(microseconds: 300), () {
      navigate('/login');
    });
  }
}

@immutable
abstract class LoginState{}

class ValidateFieldsState extends GenericState<LoginState> {}
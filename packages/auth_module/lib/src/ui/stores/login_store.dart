import 'package:auth_module/src/ui/stores/login_state.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<LoginState> {
  LoginStore({required IAuthUseCases useCases})
      : _useCases = useCases,
        super(InitialLoginState());
  final IAuthUseCases _useCases;

  final String _email = 'victor.olustosa@outlook.com';
  final String _password = '!Helena2209';

  logIn(String email, String password, BuildContext context) async {
    value = LoadingLoginState();
    Future.delayed(const Duration(seconds: 1), () {
      if (_email == email && _password == password) {
        Modular.to.navigate(AuthModule.initialRoute + AuthModule.homeRoute);
      } else {
        value = InitialLoginState();
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
    //   Modular.to.navigate('/home/');
    //   return '';
    //  } else {
    //   return 'login inválido';
    //}
  }

  validateFields() {
    value = ValidateFieldsState();
  }

  toCreateAccount() {
    Modular.to.navigate('/create-account');
  }

  Future createAccount() async {
    //_useCase.add('auth', HiveAuthDTO(token: emailController.text,));
    Future.delayed(const Duration(microseconds: 300), () {
      Modular.to.navigate('/login');
    });
  }
}

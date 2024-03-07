import 'package:auth_module/src/ui/stores/login_state.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LoginStore extends ValueNotifier<LoginState> {
  LoginStore({required IUseCases useCases}) : _useCases = useCases, super(InitialLoginState());
  final IUseCases _useCases;

  logIn(String email, String password) async {
    value = LoadingLoginState();
    var email = '';
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
  validateFields(){
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

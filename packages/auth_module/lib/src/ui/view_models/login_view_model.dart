import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  LoginViewModel({required IUseCases useCase}) : _useCase = useCase;

  final IUseCases _useCase;

  Future logIn() async {
    var email = '';
    //Stream<HiveAuthDTO> credentials = await _useCase.get('auth/${emailController.text}/${passwordController.text}');
  //  await for(final value in credentials){
   //   email = value.token;
   // }
    if (email.isNotEmpty) {
      Modular.to.navigate('/home/');
      return '';
    } else {
      return 'login inválido';
    }
  }

  logout() {
    Modular.to.navigate('/login');
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

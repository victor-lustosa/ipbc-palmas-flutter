import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountStore
    extends ValueNotifier<GenericState<CreateAccountState>> {
  CreateAccountStore() : super(InitialState<CreateAccountState>());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  bool _arePasswordEqual = false;

  get emailController => _emailController;
  get passwordController => _passwordController;
  get passwordRepeatController => _passwordRepeatController;

  get email => _emailController.text;
  get password => _passwordController.text;
  get passwordConfirm => _passwordRepeatController.text;

  bool get emptyPasswords =>
      _passwordController.text.isEmpty &&
      _passwordRepeatController.text.isEmpty;

  get arePasswordEqual {
    if (emptyPasswords) {
      _arePasswordEqual = false;
    } else {
      _arePasswordEqual = password == passwordConfirm;
    }
    return _arePasswordEqual;
  }
}

@immutable
abstract class CreateAccountState {}

@immutable
abstract class ValidateFieldsState extends GenericState<CreateAccountState> {}

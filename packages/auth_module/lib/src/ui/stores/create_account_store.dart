import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class CreateAccountStore
    extends ValueNotifier<GenericState<CreateAccountState>> {
  CreateAccountStore() : super(InitialState<CreateAccountState>());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  get emailController => _emailController;
  get passwordController => _passwordController;
  get passwordRepeatController => _passwordRepeatController;
}

@immutable
abstract class CreateAccountState {}

@immutable
abstract class ValidateFieldsState extends GenericState<CreateAccountState> {}

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class RegistrationCompletionStore
    extends ValueNotifier<GenericState<RegistrationCompletionState>> {
  RegistrationCompletionStore()
    : super(InitialState<RegistrationCompletionState>());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  TextEditingController get nameValue => _nameController;
  TextEditingController get phoneValue => _phoneController;
  TextEditingController get zipCodeValue => _zipCodeController;
  TextEditingController get dateOfBirthValue => _dateOfBirthController;

 bool get lengthPhone => _phoneController.text.length == 15;
  bool get lengthCep => _zipCodeController.text.length == 9;
}

@immutable
abstract class RegistrationCompletionState {}

@immutable
abstract class ValidateFieldsState
    extends GenericState<RegistrationCompletionState> {}

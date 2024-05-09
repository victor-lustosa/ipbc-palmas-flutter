import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationCompletionView extends StatefulWidget {
  const RegistrationCompletionView({super.key});

  @override
  State<RegistrationCompletionView> createState() =>
      _RegistrationCompletionViewState();
}

class _RegistrationCompletionViewState
    extends State<RegistrationCompletionView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();

  final _nameKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _zipCodeKey = GlobalKey<FormState>();
  final _dateOfBirthKey = GlobalKey<FormState>();
  final _maritalStatusKey = GlobalKey<FormState>();

  bool _isValidName = true;
  bool _isValidPhone = true;
  final bool _isValidcep = true;
  final _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 72, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonWidget(
                      action: () => Modular.to.navigate(
                          AuthModule.authRoute + AuthModule.createAccountRoute),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 12.5),
                      child: Text(
                        'Finalize sua conta',
                        style: AppFonts.defaultFont(
                          color: AppColors.grey10,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TemplateFormWidget(
                        controller: _nameController,
                        globalKey: _nameKey,
                        textInputType: TextInputType.text,
                        errorText: 'Preencha o nome completo',
                        isValid: _isValidName,
                        isPressed: _isPressed,
                        validator: (data) {
                          return _nameValidation(data);
                        },
                        inputDecoration: fieldInputDecoration(
                          isValid: _isValidName,
                          hintText: 'Nome completo',
                        ),
                        defaultHintColor: AppColors.grey10),
                    const SizedBox(height: 16),
                    TemplateFormWidget(
                        controller: _phoneController,
                        inputFormatters: <TextInputFormatter>[
                          PhoneInputFormatter()
                        ],
                        textInputType: TextInputType.phone,
                        globalKey: _phoneKey,
                        errorText: 'Preencha o Telefone',
                        isValid: _isValidPhone,
                        isPressed: _isPressed,
                        validator: (data) {
                          _phoneValidation(data);
                        },
                        inputDecoration: fieldInputDecoration(
                          isValid: _isValidPhone,
                          hintText: 'Telefone',
                        ),
                        defaultHintColor: AppColors.grey10),
                    const SizedBox(height: 16),
                    TemplateFormWidget(
                        inputFormatters: <TextInputFormatter>[
                          CepInputFormatter()
                        ],
                        controller: _zipCodeController,
                        globalKey: _zipCodeKey,
                        textInputType: TextInputType.number,
                        errorText: 'Preencha o CEP',
                        isValid: _isValidcep,
                        isPressed: _isPressed,
                        validator: (data) {
                          _phoneValidation(data);
                        },
                        inputDecoration: fieldInputDecoration(
                          isValid: _isValidcep,
                          hintText: 'CEP',
                        ),
                        defaultHintColor: AppColors.grey10),
                    const SizedBox(height: 16),
                    TemplateFormWidget(
                        controller: _maritalStatusController,
                        globalKey: _maritalStatusKey,
                        errorText: 'Preencha o estado civil',
                        isValid: _isValidName,
                        isPressed: _isPressed,
                        validator: (data) {
                          _nameValidation(data);
                        },
                        inputDecoration: fieldInputDecoration(
                          isValid: _isValidName,
                          hintText: 'Estado civil',
                        ),
                        defaultHintColor: AppColors.grey10),
                    const SizedBox(height: 16),
                    TemplateFormWidget(
                        controller: _dateOfBirthController,
                        globalKey: _dateOfBirthKey,
                        errorText: 'Preencha a data de nascimento',
                        isValid: _isValidName,
                        isPressed: _isPressed,
                        validator: (data) {
                          _nameValidation(data);
                        },
                        inputDecoration: fieldInputDecoration(
                          isValid: _isValidName,
                          hintText: 'Data de nascimento',
                        ),
                        defaultHintColor: AppColors.grey10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nameBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isValidName = value;
        });
      }
    });
  }

  _nameValidation(String? data) {
    if (data == null || data.isEmpty) {
      _nameBorderValidation(false);
    } else {
      _nameController.text.isNotEmpty
          ? _nameBorderValidation(true)
          : _nameBorderValidation(false);
    }
  }

  _phoneValidation(String value) {
    String regexpPhone = (r'[\D]');
    RegExp regExp = RegExp(regexpPhone);

    if (value.isEmpty) {
      return _isValidPhone = false;
    } else if (value.trim().length != 15) {
      return _isValidPhone = false;
    } else if (!regExp.hasMatch(value)) {
      return _isValidPhone = false;
    }
    return _isValidPhone = true;
  }
}

_phoneValidation(String value) {
  if (value.isEmpty) {
    return false;
  } else if (value.trim().length != 9) {
    return false;
  }
  return true;
}

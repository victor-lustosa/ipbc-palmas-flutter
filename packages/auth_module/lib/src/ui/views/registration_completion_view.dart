import 'package:auth_module/src/ui/stores/registration_completion_store.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
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
  final RegistrationCompletionStore _store =
      Modular.get<RegistrationCompletionStore>();

  final _nameKey = GlobalKey<FormState>();
  final _phoneKey = GlobalKey<FormState>();
  final _zipCodeKey = GlobalKey<FormState>();
  final _dateOfBirthKey = GlobalKey<FormState>();
  final _maritalStatusKey = GlobalKey<FormState>();

  bool _isValidName = true;
  bool _isValidPhone = true;
  bool isValidCep = true;
  bool? isChecked;
  final _isPressed = false;
  bool isCheckedAcceptContact = false;
  bool isCheckedMember = false;

  String dropdownvalue = 'Solteiro(a)';

  var items = [
    'Solteiro(a)',
    'Casado(a)',
    'Divorciado(a)',
    'Viuvo(a)',
  ];
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
            Column(
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
                    fieldMargin: EdgeInsets.zero,
                    fieldHeight: 44,
                    controller: _store.nameValue,
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
                    fieldMargin: EdgeInsets.zero,
                    fieldHeight: 44,
                    controller: _store.phoneValue,
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
                    inputFormatters: <TextInputFormatter>[CepInputFormatter()],
                    fieldHeight: 44,
                    fieldMargin: EdgeInsets.zero,
                    controller: _store.zipCodeValue,
                    readOnly: false,
                    globalKey: _zipCodeKey,
                    textInputType: TextInputType.number,
                    errorText: 'Preencha o CEP',
                    isValid: isValidCep,
                    isPressed: _isPressed,
                    validator: (data) {},
                    inputDecoration: fieldInputDecoration(
                      isValid: isValidCep,
                      hintText: 'CEP',
                    ),
                    defaultHintColor: AppColors.grey10),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: DropdownWidget(
                    key: _maritalStatusKey,
                    name: "Estado civil",
                    icon: const Icon(Icons.keyboard_arrow_down),
                    list: items,
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    sizeBorderRadius: 16,
                    colorBorder: AppColors.secondaryGrey,
                    (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),
                TemplateFormWidget(
                    fieldMargin: EdgeInsets.zero,
                    fieldHeight: 44,
                    controller: _store.dateOfBirthValue,
                    readOnly: false,
                    textInputType: TextInputType.datetime,
                    globalKey: _dateOfBirthKey,
                    errorText: 'Preencha a data de nascimento',
                    isValid: _isValidName,
                    isPressed: _isPressed,
                    validator: (data) {},
                    inputDecoration: fieldInputDecoration(
                      suffixIconConstraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: IconButtonWidget(
                          action: selectDate,
                          size: 24,
                          color: AppColors.grey7,
                          iOSIcon: CupertinoIcons.calendar,
                          androidIcon: Icons.date_range,
                        ),
                      ),
                      isValid: _isValidName,
                      hintText: 'Data de nascimento',
                    ),
                    defaultHintColor: AppColors.grey10),
                const SizedBox(height: 40),
                Text(
                  'Você já é membro da Igreja IPB Palmas?',
                  style: AppFonts.defaultFont(
                      color: AppColors.grey9,
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 16),
                CheckBoxCustom(
                  isChecked: isChecked == false,
                  margin: const EdgeInsets.only(right: 16, left: 16),
                  textCheckedBox: 'Sim',
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = !value!;
                      isCheckedAcceptContact = false;
                      isCheckedMember = false;
                    });
                  },
                ),
                CheckBoxCustom(
                  isChecked: isChecked == true,
                  margin: const EdgeInsets.only(top: 8, right: 16, left: 16),
                  textCheckedBox: 'Não',
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    CheckBoxCustom(
                      borderRadiusCheckBox: 2,
                      colorBoder:
                          isChecked == true ? AppColors.grey9 : AppColors.grey3,
                      margin: const EdgeInsets.only(
                          top: 8, left: 16, right: 16, bottom: 8),
                      isChecked: isCheckedMember,
                      iconCheckBox: Icons.check,
                      sizeIcon: 19,
                      textCheckedBox: 'Quero me tornar membro',
                      textStyle: AppFonts.defaultFont(
                          color: isChecked == true
                              ? AppColors.grey9
                              : AppColors.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                      onChanged: (bool value) {
                        setState(() {
                          if (isChecked == true) {
                            isCheckedMember = value;
                          }
                        });
                      },
                    ),
                    CheckBoxCustom(
                      colorBoder:
                          isChecked == true ? AppColors.grey9 : AppColors.grey3,
                      isChecked: isCheckedAcceptContact,
                      iconCheckBox: Icons.check,
                      sizeIcon: 19,
                      borderRadiusCheckBox: 2,
                      textStyle: AppFonts.defaultFont(
                          color: isChecked == true
                              ? AppColors.grey9
                              : AppColors.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                      margin: const EdgeInsets.only(
                          top: 8, left: 16, right: 16, bottom: 98),
                      textCheckedBox: 'Aceito que entrem em contato',
                      onChanged: (bool value) {
                        setState(() {
                          if (isChecked == true) {
                            isCheckedAcceptContact = value;
                          }
                        });
                      },
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: ButtonWidget(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width, 48),
                    action: () {
                      selectDate();
                    },
                    backgroundColor: AppColors.disableButton,
                    shadowColor: AppColors.grey0,
                    foregroundColor: AppColors.white,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Salvar",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    ));
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
      _store.nameValue.text.isNotEmpty
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

  bool validateCEP(String cep) {
    cep = cep.replaceAll(RegExp(r'[^\d]'), '');

    if (cep.length != 8) {
      return isValidCep == false;
    }
    return isValidCep == true;
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      context: context,
    );
    if (picked != null) {
      setState(() {
        _store.dateOfBirthValue.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../auth_module.dart';
import '../stores/registration_completion_store.dart';

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

  final _isPressed = false;
  bool _isValidName = true;
  bool _isValidPhone = true;
  bool _isValidCep = true;
  bool? isChecked;
  bool isCheckedAcceptContact = false;
  bool isCheckedMember = false;
  bool _isValidDate = true;

  String dropdownvalue = 'Solteiro(a)';

  var items = ['Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viuvo(a)'];

  @override
  void dispose() {
    super.dispose();
  }

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
                      action:
                          () => Modular.to.navigate(
                            AppRoutes.authRoute +
                                AppRoutes.createAccountRoute,
                          ),
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
                    defaultHintColor: AppColors.grey10,
                  ),
                  const SizedBox(height: 16),
                  TemplateFormWidget(
                    fieldMargin: EdgeInsets.zero,
                    fieldHeight: 44,
                    controller: _store.phoneValue,
                    inputFormatters: <TextInputFormatter>[
                      PhoneInputFormatter(),
                    ],
                    textInputType: TextInputType.phone,
                    globalKey: _phoneKey,
                    errorText: 'Preencha o Telefone',
                    isValid: _isValidPhone,
                    isPressed: _isPressed,
                    validator: (data) {
                      return _phoneValidation(data);
                    },
                    inputDecoration: fieldInputDecoration(
                      isValid: _isValidPhone,
                      hintText: 'Telefone',
                    ),
                    defaultHintColor: AppColors.grey10,
                  ),
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
                    isValid: _isValidCep,
                    isPressed: _isPressed,
                    validator: (data) {
                      return _cepValidation(data);
                    },
                    inputDecoration: fieldInputDecoration(
                      isValid: _isValidCep,
                      hintText: 'CEP',
                    ),
                    defaultHintColor: AppColors.grey10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: DropdownWidget(
                      key: _maritalStatusKey,
                      name: "Estado civil",
                      icon: const Icon(Icons.keyboard_arrow_down),
                      colorSelect: AppColors.grey10,
                      list: items,
                      textStyle: AppFonts.defaultFont(
                        fontSize: 13,
                        color: AppColors.grey10,
                        fontWeight: FontWeight.w400,
                      ),
                      width: context.sizeOf.width,
                      height: 48,
                      marginContent: const EdgeInsets.only(left: 16, right: 16),
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
                    inputFormatters: <TextInputFormatter>[DataInputFormatter()],
                    errorText: 'Preencha a data de nascimento',
                    isValid: _isValidDate,
                    isPressed: _isPressed,
                    validator: (data) {
                      return _dateValidation(data);
                    },
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
                      isValid: _isValidDate,
                      hintText: 'Data de nascimento',
                    ),
                    defaultHintColor:
                        _isValidDate ? AppColors.grey10 : AppColors.delete,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Você já é membro da Igreja IPB Palmas?',
                      style: AppFonts.defaultFont(
                        color: AppColors.grey9,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomCheckBox(
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
                  CustomCheckBox(
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
                      CustomCheckBox(
                        borderRadiusCheckBox: 2,
                        colorBoder:
                            isChecked == true
                                ? AppColors.grey9
                                : AppColors.grey3,
                        margin: const EdgeInsets.only(
                          top: 8,
                          left: 16,
                          right: 16,
                          bottom: 8,
                        ),
                        isChecked: isCheckedMember,
                        iconCheckBox: Icons.check,
                        sizeIcon: 19,
                        textCheckedBox: 'Quero me tornar membro',
                        textStyle: AppFonts.defaultFont(
                          color:
                              isChecked == true
                                  ? AppColors.grey9
                                  : AppColors.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: (bool value) {
                          setState(() {
                            if (isChecked == true) {
                              isCheckedMember = value;
                            }
                          });
                        },
                      ),
                      CustomCheckBox(
                        colorBoder:
                            isChecked == true
                                ? AppColors.grey9
                                : AppColors.grey3,
                        isChecked: isCheckedAcceptContact,
                        iconCheckBox: Icons.check,
                        sizeIcon: 19,
                        borderRadiusCheckBox: 2,
                        textStyle: AppFonts.defaultFont(
                          color:
                              isChecked == true
                                  ? AppColors.grey9
                                  : AppColors.grey3,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        margin: const EdgeInsets.only(
                          top: 8,
                          left: 16,
                          right: 16,
                          bottom: 98,
                        ),
                        textCheckedBox: 'Aceito que entrem em contato',
                        onChanged: (bool value) {
                          setState(() {
                            if (isChecked == true) {
                              isCheckedAcceptContact = value;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: ButtonWidget(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      fixedSize: Size(context.sizeOf.width, 48),
                      action: () {
                        selectDate();
                      },
                      backgroundColor: AppColors.disableButton,
                      shadowColor: AppColors.grey0,
                      foregroundColor: AppColors.white,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("Salvar")],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Finalizar depois',
                    style: AppFonts.defaultFont(
                      color: AppColors.darkGreen,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
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
      _store.nameValue.text.isNotEmpty
          ? _nameBorderValidation(true)
          : _nameBorderValidation(false);
    }
  }

  _phoneBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isValidPhone = value;
        });
      }
    });
  }

  _phoneValidation(String? value) {
    if (value == null || value.isEmpty) {
      _phoneBorderValidation(false);
    } else {
      (_store.lengthPhone)
          ? _phoneBorderValidation(true)
          : _phoneBorderValidation(false);
    }
  }

  _cepBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isValidCep = value;
        });
      }
    });
  }

  _cepValidation(String? value) {
    if (value == null || value.isEmpty) {
      _cepBorderValidation(false);
    } else {
      (value.length == 9)
          ? _cepBorderValidation(true)
          : _cepBorderValidation(false);
    }
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

  void _dateBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      if (mounted) {
        setState(() {
          _isValidDate = value;
        });
      }
    });
  }

  _dateValidation(String? value) {
    if (value == null || value.isEmpty) {
      _dateBorderValidation(false);
      return false;
    } else {
      bool isValidDate = _validateDate(value);
      _dateBorderValidation(isValidDate);
      return isValidDate;
    }
  }

  bool _validateDate(String value) {
    // formato "dd/MM/yyyy"
    RegExp dateRegExp = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegExp.hasMatch(value)) {
      return false;
    }

    // Divide a string da data em dia, mês e ano
    List<String> parts = value.split('/');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Verifica se o mês está entre 1 e 12
    if (month < 1 || month > 12) {
      return false;
    }

    // Verifica o número de dias em cada mês, considerando anos bissextos
    List<int> daysInMonth = [
      31,
      (isLeapYear(year) ? 29 : 28),
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];

    // Verifica se o dia está dentro do limite para o mês específico
    if (day < 1 || day > daysInMonth[month - 1]) {
      return false;
    }

    return true;
  }

  bool isLeapYear(int year) {
    if (year % 4 != 0) return false;
    if (year % 100 == 0 && year % 400 != 0) return false;
    return true;
  }
}

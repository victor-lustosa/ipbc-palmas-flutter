import 'package:core_module/core_module.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

//import '../../components/default_field_widget.dart';
//import '../../configs/app_configs.dart';

class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({super.key});

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  final _emailKey = GlobalKey<FormState>();

  String emailErrorText = 'por favor, insira um email válido.';

  bool _isEmailValid = true;

  _fieldDecoration({required isValid}) => BoxDecoration(
    color: const Color(0xffffffff),
    border: Border.all(
      color: isValid ? AppColors.inputBorderGrey : Colors.red,
    ),
    borderRadius: BorderRadius.circular(16),
  );
  
  _inputDecoration({required isValid, required hintText}) {
    return InputDecoration(
      border: InputBorder.none,
      hintStyle: AppFonts.defaultFont(
        fontSize: 12,
        color: isValid ? AppColors.hintInputForm : Colors.red,
      ),
      contentPadding: const EdgeInsets.only(
        left: 16,
        bottom: 5,
        right: 5,
      ),
      hintText: hintText,
      counterStyle: AppFonts.defaultFont(
        fontSize: 10,
        color: isValid ? const Color(0xff979797) : Colors.red,
      ),
    );
  }

  _emailBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _isEmailValid = value;
      });
    });
  }

  _emailValidation(String? data) {
    if (data == null || data.isEmpty) {
      _emailBorderValidation(false);
      return null;
    } else {
      if (EmailValidator.validate(_emailController.text)) {
        _emailBorderValidation(true);
        return null;
      } else {
        _emailBorderValidation(false);
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 108),
                child: Text(
                  "Redefinir senha",
                  style: AppFonts.defaultFont(
                    color: AppColors.grey10,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32),
                width: MediaQuery.of(context).size.width,
                child: DefaultFieldWidget(
                horizontalSymmetric: const EdgeInsets.symmetric(horizontal: 16),
                fieldMargin: const EdgeInsets.only(top: 8),
                titleStyle: AppFonts.defaultFont(
                  color: AppColors.grey10,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                title: 'Insira seu e-mail ou telefone',
                isValid: _isEmailValid,
                controller: _emailController,
                inputDecoration: _inputDecoration(
                  isValid: _isEmailValid,
                  hintText: 'Email',
                  
                ),
                fieldDecoration: _fieldDecoration(isValid: _isEmailValid),
                errorText: emailErrorText,
                fieldHeight: 48,
                validator: (data) {
                  return _emailValidation(data);
                },
              ) ,
              )
            ],
          ),
        ),
      ),
    );
  }
}
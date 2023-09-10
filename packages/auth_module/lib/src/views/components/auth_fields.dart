import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AuthFields extends StatefulWidget {
  const AuthFields({super.key});

  @override
  State<AuthFields> createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();

  String emailErrorText = 'por favor, insira um email válido.';
  String passwordErrorText = 'por favor, insira uma senha.';

  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [emailField(), passwordField()],
    );
  }

  emailField() => DefaultFieldWidget(
        fieldKey: _emailKey,
    horizontalSymmetric: const EdgeInsets.symmetric(horizontal: 16),
        fieldMargin: const EdgeInsets.only(top: 4),
        fieldDecoration: _fieldDecoration(isValid: _isEmailValid),
        title: 'Insira seu email',
        isValid: _isEmailValid,
        controller: _emailController,
        inputDecoration: _inputDecoration(
          isValid: _isEmailValid,
          hintText: 'Email',
        ),
        errorText: emailErrorText,
        fieldHeight: 48,
        validator: (data) {
          return _emailValidation(data);
        },
      );

  passwordField() => DefaultFieldWidget(
        fieldKey: _passwordKey,
        horizontalSymmetric: const EdgeInsets.symmetric(horizontal: 16),
        titleMargin: EdgeInsets.only(top: _isEmailValid ? 24 : 12),
        fieldMargin: const EdgeInsets.only(top: 4),
        fieldDecoration: _fieldDecoration(isValid: _isPasswordValid),
        title: 'Insira sua senha',
        isValid: _isPasswordValid,
        obscureText: true,
        controller: _passwordController,
        fieldHeight: 48,
        errorText: passwordErrorText,
        inputDecoration: _inputDecoration(
          isValid: _isPasswordValid,
          hintText: 'Senha',
        ),
        validator: (data) {
          return _passwordValidation(data);
        },
      );

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

  _passwordBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
      setState(() {
        _isPasswordValid = value;
      });
    });
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

  _passwordValidation(String? data) {
    if (data == null || data.isEmpty) {
      _passwordBorderValidation(false);
      return null;
    } else {
      _passwordBorderValidation(true);
      return null;
    }
  }
}
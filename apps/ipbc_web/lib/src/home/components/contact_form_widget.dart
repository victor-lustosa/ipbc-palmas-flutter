import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  late double vWidth;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final double mdSize = 770;

  final _nameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _messageKey = GlobalKey<FormState>();

  String nameErrorText = 'por favor, insira um nome.';
  String emailErrorText = 'por favor, insira um email válido.';
  String messageErrorText = 'por favor, insira uma mensagem.';

  bool _isNameValid = true;
  bool _isEmailValid = true;
  bool _isMessageValid = true;
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    vWidth = context.mediaQuery.size.width;
    if (vWidth > mdSize) {
      return web();
    } else {
      return mobile();
    }
  }

  web() => Container(
        width: vWidth,
        decoration: const BoxDecoration(color: AppColors.grey0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title(),
            subtitle(width: 500),
            nameField(width: 500),
            emailField(width: 500),
            messageField(width: 500),
            sendButton(width: 500),
          ],
        ),
      );

  mobile() => Container(
        decoration: const BoxDecoration(color: AppColors.grey0),
        width: vWidth,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title(),
                  subtitle(width: vWidth * .7),
                  nameField(
                    width: vWidth < 500
                      ? vWidth
                      : 500,
                  ),
                  emailField(
                    width: vWidth < 500
                      ? vWidth
                      : 500,
                  ),
                  messageField(
                    width: vWidth < 500
                      ? vWidth
                      : 500,
                  ),
                  sendButton(
                    width: vWidth < 500
                      ? vWidth
                      : 500,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  title() => Container(
        margin: const EdgeInsets.only(top: 80, bottom: 16),
        child: Text(
          'Entre em contato',
          textAlign: TextAlign.center,
          style: AppFonts.defaultFont(
            fontSize: 32,
            color: AppColors.grey12,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  subtitle({required double width}) => Container(
        width: width,
        margin: const EdgeInsets.only(bottom: 40),
        child: Text(
          'Envie seu pedido de oração, solicitação ou dúvida.',
          textAlign: TextAlign.center,
          style: AppFonts.defaultFont(
            height: 1.5,
            color: AppColors.grey8,
          ),
        ),
      );

  nameField({required double width}) => DefaultFormFieldWidget(
        fieldKey: _nameKey,
        titleMargin: const EdgeInsets.only(bottom: 8),
        title: 'Nome',
        titleStyle: _titleStyle,
        isValid: _isNameValid,
        controller: _nameController,
        errorText: nameErrorText,
        validator: (data) {
          return _nameValidation(data);
        },
        fieldWidth: width,
        isSubmitted: !_isSubmitted,
        inputDecoration: _inputDecoration(
            isValid: _isNameValid, hintText: 'Seu nome completo'),
        fieldStyle: _fieldStyle(_isNameValid),
      );

  emailField({required double width}) => DefaultFormFieldWidget(
        fieldKey: _emailKey,
        titleStyle: _titleStyle,
        titleMargin: const EdgeInsets.only(top: 16, bottom: 8),
        title: 'Email',
        isValid: _isEmailValid,
        controller: _emailController,
        errorText: emailErrorText,
        fieldWidth: width,
        isSubmitted: !_isSubmitted,
        inputDecoration: _inputDecoration(
          isValid: _isEmailValid,
          hintText: 'me@company.com',
        ),
        fieldStyle: _fieldStyle(_isEmailValid),
        validator: (data) {
          return _emailValidation(data);
        },
      );

  messageField({required double width}) => DefaultFormFieldWidget(
        fieldKey: _messageKey,
        titleStyle: _titleStyle,
        title: 'Mensagem',
        isValid: _isMessageValid,
        controller: _messageController,
        errorText: messageErrorText,
        titleMargin: const EdgeInsets.only(top: 16, bottom: 8),
        maxLines: 5,
        maxLength: 500,
        fieldHeight: 115,
        validator: (data) {
          return _messageValidation(data);
        },
        fieldWidth: width,
        isSubmitted: !_isSubmitted,
        fieldStyle: _fieldStyle(_isMessageValid),
        inputDecoration: _inputDecoration(
          isValid: _isMessageValid,
          hintText: 'Sua mensagem...',
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            //top 8 pra celular
          ),
        ),
      );

  _inputDecoration(
      {required isValid,
      required hintText,
      EdgeInsetsGeometry? contentPadding}) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      border: InputBorder.none,
      contentPadding: contentPadding ??
          const EdgeInsets.only(
            left: 10,
            right: 10,
            //top 11 pra celular
            top: 16,
          ),
      counterStyle: AppFonts.defaultFont(
        fontSize: 10,
        color: isValid
            ? const Color(0xff979797)
            : AppColors.delete,
      ),
      hintStyle: AppFonts.defaultFont(
        fontSize: 14,
        color: isValid
            ? const Color(0xff979797)
            : AppColors.delete,
      ),
    );
  }

  _fieldStyle(isValid) {
    return AppFonts.defaultFont(
      fontSize: 14,
      color: isValid
          ? const Color(0xff979797)
          : AppColors.delete,
    );
  }

  get _titleStyle => AppFonts.defaultFont(
        fontSize: 14,
        color: AppColors.grey8,
      );

  sendButton({required double width}) => Container(
        width: width,
        height: 49,
        margin: const EdgeInsets.only(top: 32, bottom: 80),
        child: ElevatedButtonWidget(
          shadowColor: AppColors.grey6,
          backgroundColor: _isSubmitted
              ? AppColors.highlightGreen
              : AppColors.darkGreen,
          overlayColor: _isSubmitted
              ? AppColors.highlightGreen
              : null,
          foregroundColor: _isSubmitted
              ? AppColors.grey12
              : AppColors.white,
          action: () {
            if (_nameController.text.isEmpty && !_isSubmitted) {
              _nameBorderValidation(false);
            }
            if (_emailController.text.isEmpty && !_isSubmitted) {
              _emailBorderValidation(false);
            }
            if (_messageController.text.isEmpty && !_isSubmitted) {
              _messageBorderValidation(false);
            }
            if (_nameController.text.isNotEmpty &&
                _emailController.text.isNotEmpty &&
                _messageController.text.isNotEmpty &&
                _isNameValid &&
                _isEmailValid &&
                _isMessageValid &&
                !_isSubmitted) {
              if (EmailValidator.validate(_emailController.text)) {
                setState(() {
                  _isSubmitted = true;
                });
                _nameController.clear();
                _messageController.clear();
                _emailController.clear();
              } else {
                _emailBorderValidation(false);
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isSubmitted
                    ? 'Enviado!'
                    : 'Enviar',
              )
            ],
          ),
        ),
      );

  _nameBorderValidation(bool value) async =>
      Future.delayed(Duration.zero, () async {
        setState(() {
          _isNameValid = value;
        });
      });

  _emailBorderValidation(bool value) async =>
      Future.delayed(Duration.zero, () async {
        setState(() {
          _isEmailValid = value;
        });
      });

  _messageBorderValidation(bool value) async =>
      Future.delayed(Duration.zero, () async {
        setState(() {
          _isMessageValid = value;
        });
      });

  _emailValidation(String? data) {
    if (data == null || data.isEmpty && !_isSubmitted) {
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

  _nameValidation(String? data) {
    if (data == null || data.isEmpty && !_isSubmitted) {
      _nameBorderValidation(false);
      return null;
    } else {
      _nameBorderValidation(true);
      return null;
    }
  }

  _messageValidation(String? data) {
    if (data == null || data.isEmpty && !_isSubmitted) {
      _messageBorderValidation(false);
      return null;
    } else {
      _messageBorderValidation(true);
      return null;
    }
  }
}

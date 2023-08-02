import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

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
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: 13,
              top: 100,
            ),
            child: Text(
              'Entre em contato',
              textAlign: TextAlign.center,
              style: AppFonts.defaultFont(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: const Color(0xff242426),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 42),
            child: Text(
              'Envie seu pedido de oração, solicitação ou dúvida.',
              textAlign: TextAlign.center,
              style: AppFonts.defaultFont(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xff545456),
              ),
            ),
          ),
          field(
              key: _nameKey,
              margin: const EdgeInsets.only(bottom: 8),
              title: 'Nome',
              isValid: _isNameValid,
              controller: _nameController,
              hintText: 'Seu nome completo',
              errorText: nameErrorText,
              validator: (data) {
                return _nameValidation(data);
              }),
          field(
              key: _emailKey,
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              title: 'Email',
              isValid: _isEmailValid,
              controller: _emailController,
              hintText: 'me@company.com',
              errorText: emailErrorText,
              validator: (data) {
                return _emailValidation(data);
              }),
          field(
              key: _messageKey,
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              title: 'Mensagem',
              isValid: _isMessageValid,
              controller: _messageController,
              hintText: 'Sua mensagem...',
              errorText: messageErrorText,
              isDense: true,
              maxLines: 5,
              maxLength: 500,
              heightField: 110,
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 11,
              ),
              validator: (data) {
                return _messageValidation(data);
              }),
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 100),
            width: 500,
            height: 49,
            child: ElevatedButton(
              style: ButtonStyle(
                overlayColor: _isSubmitted
                    ? MaterialStateProperty.all<Color>(const Color(0xFF00E8A2))
                    : null,
                foregroundColor: _isSubmitted
                    ? MaterialStateProperty.all<Color>(const Color(0xff242426))
                    : MaterialStateProperty.all<Color>(AppColors.white),
                shadowColor: MaterialStateProperty.all<Color>(AppColors.grey6),
                backgroundColor: _isSubmitted
                    ? MaterialStateProperty.all<Color>(const Color(0xFF00E8A2))
                    : MaterialStateProperty.all<Color>(AppColors.darkGreen),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                textStyle: MaterialStateProperty.all<TextStyle?>(
                  AppFonts.defaultFont(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ),
              onPressed: () {
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
                  if(EmailValidator.validate(_emailController.text)){
                    setState(() {
                      _isSubmitted = true;
                    });
                    _nameController.clear();
                    _messageController.clear();
                    _emailController.clear();
                  } else{
                    _emailBorderValidation(false);
                  }
                }
              },
              child: Center(
                child: Text(
                  _isSubmitted ? 'Enviado!' : 'Enviar',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _nameBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
    setState(() {
      _isNameValid = value;
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

  _messageBorderValidation(bool value) {
    Future.delayed(Duration.zero, () async {
    setState(() {
      _isMessageValid = value;
      });
    });
  }

  _emailValidation(String? data) {
    if (data == null || data.isEmpty && !_isSubmitted) {
        _emailBorderValidation(false);
        return null;
    } else {
      if (EmailValidator.validate(_emailController.text)) {
        _emailBorderValidation(true);
        return null;
      } else{
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

  field(
      {required Key key,
      required String title,
      required bool isValid,
      required String hintText,
      required String errorText,
      required FormFieldValidator validator,
      required TextEditingController controller,
      bool? isDense,
      int? maxLines,
      int? maxLength,
      double? heightField,
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? contentPadding}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: margin,
          child: Text(
            title,
            style: AppFonts.defaultFont(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: const Color(0xff545456),
            ),
          ),
        ),
        Container(
          width: 500,
          height: heightField ?? 42,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            border: Border.all(
              color: isValid
                  ? AppColors.white
                  : Colors.red,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            key: key,
            enabled: !_isSubmitted,
            cursorColor: const Color(0xff979797),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            validator: validator,
            maxLines: maxLines,
            maxLength: maxLength,
            keyboardType: TextInputType.text,
            inputFormatters: const <TextInputFormatter>[],
            decoration: InputDecoration(
              counterStyle: AppFonts.defaultFont(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: isValid
                    ? const Color(0xff979797)
                    : Colors.red,
              ),
              isDense: isDense,
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: contentPadding ??
                  const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
              hintStyle: AppFonts.defaultFont(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isValid
                    ? const Color(0xff979797)
                    : Colors.red,
              ),
            ),
            style: AppFonts.defaultFont(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isValid
                  ? const Color(0xff979797)
                  : Colors.red,
            ),
          ),
        ),
        Visibility(
          visible: !isValid,
          child: Container(
            margin: const EdgeInsets.only(top: 4, left: 2),
            child: Text(
              errorText,
              style: AppFonts.defaultFont(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}

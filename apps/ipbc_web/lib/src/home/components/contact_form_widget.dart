import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> with EmailMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final _nameKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _messageKey = GlobalKey<FormState>();

  String? nameErrorText;
  String? emailErrorText;
  String? messageErrorText;

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isMessageValid = true;
  bool isSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 13, top: 100),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Nome',
                  style: AppFonts.defaultFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff545456),
                  ),
                ),
              ),
              Container(
                width: 500,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  border: Border.all(
                      color: isNameValid ? AppColors.white : Colors.red),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  enabled: !isSubmitted,
                  key: _nameKey,
                  cursorColor: const Color(0xff979797),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: false,
                  controller: nameController,
                  validator: (data) {
                    return nameValidation(data);
                  },
                  keyboardType: TextInputType.text,
                  inputFormatters: const <TextInputFormatter>[],
                  decoration: InputDecoration(
                    errorText: nameErrorText,
                    contentPadding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 9,
                    ),
                    hintText: 'Seu nome completo',
                    hintStyle: AppFonts.defaultFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff979797),
                    ),
                    border: InputBorder.none,
                  ),
                  style: AppFonts.defaultFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff979797),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 19, bottom: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Email',
                    style: AppFonts.defaultFont(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff545456),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  return Container(
                    width: 500,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      border: Border.all(
                          color: isEmailValid ? AppColors.white : Colors.red),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      enabled: !isSubmitted,
                      key: _emailKey,
                      cursorColor: const Color(0xff979797),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      autofocus: false,
                      controller: emailController,
                      validator: (data) {
                        return emailValidation(data);
                      },
                      keyboardType: TextInputType.text,
                      inputFormatters: const <TextInputFormatter>[],
                      decoration: InputDecoration(
                        errorText: emailErrorText,
                        contentPadding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 9,
                        ),
                        hintText: 'me@company.com',
                        hintStyle: AppFonts.defaultFont(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff979797),
                        ),
                        border: InputBorder.none,
                      ),
                      style: AppFonts.defaultFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff979797),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Mensagem',
                  style: AppFonts.defaultFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff545456),
                  ),
                ),
              ),
              Container(
                width: 500,
                height: 110,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: isMessageValid ? AppColors.white : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
                  enabled: !isSubmitted,
                  key: _messageKey,
                  validator: (data) {
                    return messageValidation(data);
                  },
                  cursorColor: const Color(0xff979797),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: false,
                  scrollPadding: const EdgeInsets.all(40.0),
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  inputFormatters: const <TextInputFormatter>[],
                  maxLines: 5,
                  maxLength: 500,
                  decoration: InputDecoration(
                      focusColor: AppColors.grey0,
                      counterStyle: const TextStyle(color: Color(0xff979797)),
                      contentPadding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 13,
                      ),
                      errorText: messageErrorText,
                      hintText: 'Sua mensagem...',
                      isDense: true,
                      hintStyle: AppFonts.defaultFont(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff979797),
                      ),
                      border: InputBorder.none),
                  style: AppFonts.defaultFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff979797),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 32, bottom: 98),
            width: 500,
            height: 49,
            child: ElevatedButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColors.white),
                // overlayColor: MaterialStateProperty.all<Color>(AppColors.darkGreen),
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.darkGreen),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    messageController.text.isNotEmpty) {
                  if (!EmailValidator.validate(emailController.text)) {
                    callEmailValidationBorder();
                  } else {
                      setState(() {
                        isSubmitted = true;
                      });
                    /* sendGrid(
                      body: '${nameController.text} /n ${messageController.text}',
                      subject: 'victor.olustosa@outlook.com',
                      recipients: [emailController.text],
                    );*/
                    nameController.clear();
                    messageController.clear();
                    emailController.clear();
                  }
                }
              },
              child:  Center(
                child: Text(
                  isSubmitted ? 'Enviado!' : 'Enviar',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  cleanEmailValidationBorder() {
    Future.delayed(Duration.zero, () async {
      setState(() {
        isEmailValid = true;
        emailErrorText = null;
      });
    });
  }

  callEmailValidationBorder() {
    Future.delayed(Duration.zero, () async {
      setState(() {
        emailErrorText = 'por favor, escreva um email válido.';
        isEmailValid = false;
      });
    });
  }

  emailValidation(String? data) {
    if (data != null && !isSubmitted) {
      if (data.isEmpty && emailErrorText == null) {
        callEmailValidationBorder();
        return null;
      }
      if (data.isNotEmpty &&
          emailErrorText != null &&
          EmailValidator.validate(emailController.text)) {
        cleanEmailValidationBorder();
        return null;
      }
    } else {
      cleanEmailValidationBorder();
      return null;
    }
  }

  nameValidation(String? data) {
    if (data == null || data.isEmpty && !isSubmitted) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          isNameValid = false;
        });
      });
      return null;
    } else {
      Future.delayed(Duration.zero, () async {
        setState(() {
          isNameValid = true;
        });
      });
      return null;
    }
  }

  messageValidation(String? data) {
    if (data == null || data.isEmpty && !isSubmitted) {
      Future.delayed(Duration.zero, () async {
        setState(() {
          isMessageValid = false;
        });
      });
      return null;
    } else {
      Future.delayed(Duration.zero, () async {
        setState(() {
          isMessageValid = true;
        });
      });
      return null;
    }
  }
}

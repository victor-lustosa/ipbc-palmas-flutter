import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

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
          fieldForm('Nome', 'Seu nome completo', nameController),
          Container(
            margin: const EdgeInsets.only(top: 19, bottom: 19),
            child: fieldForm('Email', 'me@company.com', emailController),
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
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextFormField(
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
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10, top: 13),
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
              onPressed: () {},
              child: const Center(
                child: Text(
                  'Enviar',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  fieldForm(String label, String hintText,
          TextEditingController formFieldController) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              label,
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofocus: false,
              controller: formFieldController,
              keyboardType: TextInputType.text,
              inputFormatters: const <TextInputFormatter>[],
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 9),
                hintText: hintText,
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
      );
}

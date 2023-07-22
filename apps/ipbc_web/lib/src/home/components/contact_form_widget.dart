import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15, top: 100),
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
          Text(
            'Envie seu pedido de oração, solicitação ou dúvida.',
            textAlign: TextAlign.center,
            style: AppFonts.defaultFont(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xff545456),
            ),
          ),
          const SizedBox(height: 40),
          fieldForm('Nome', 'Seu nome completo'),
          const SizedBox(height: 16),
          fieldForm('Email', 'me@company.com'),
          const SizedBox(height: 16),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Sua mensagem...',
                  style: AppFonts.defaultFont(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff979797),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            width: 500,
            height: 49,
            decoration: BoxDecoration(
              color: const Color(0xff005b40),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'Enviar',
                style: AppFonts.defaultFont(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  fieldForm(String label, nameField) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 8),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              nameField,
              style: AppFonts.defaultFont(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff979797),
              ),
            ),
          ),
        ],
      );
}

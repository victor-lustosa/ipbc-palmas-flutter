import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_web/src/home/view_models/home_view_model.dart';

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    viewModel = Modular.get<HomeViewModel>();
    viewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.vWidth = context.sizeOf.width;
    return ValueListenableBuilder(
      valueListenable: viewModel,
      builder: (_, state, child) {
        if (viewModel.vWidth > viewModel.mdSize) {
          return web();
        } else {
          return mobile();
        }
      },
    );
  }

  web() => Container(
    width: viewModel.vWidth,
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
    width: viewModel.vWidth,
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              title(),
              subtitle(width: viewModel.vWidth * .7),
              nameField(width: viewModel.vWidth < 500 ? viewModel.vWidth : 500),
              emailField(
                width: viewModel.vWidth < 500 ? viewModel.vWidth : 500,
              ),
              messageField(
                width: viewModel.vWidth < 500 ? viewModel.vWidth : 500,
              ),
              sendButton(
                width: viewModel.vWidth < 500 ? viewModel.vWidth : 500,
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
      style: AppFonts.defaultFont(height: 1.5, color: AppColors.grey8),
    ),
  );

  nameField({required double width}) => FormFieldWidget(
    fieldDecoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(
        color: viewModel.isNameValid.value ? AppColors.white : AppColors.delete,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    fieldKey: viewModel.nameKey,
    titleMargin: const EdgeInsets.only(bottom: 8),
    title: 'Nome',
    titleStyle: _titleStyle,
    isValid: viewModel.isNameValid.value,
    controller: viewModel.nameController,
    errorText: viewModel.nameErrorText,
    onChanged: (data) {
      viewModel.formValidation(
        !viewModel.isEmptyData(data),
        viewModel.isNameValid,
      );
    },
    fieldWidth: width,
    isSubmitted: !viewModel.isSubmitted.value,
    inputDecoration: _inputDecoration(
      isValid: viewModel.isNameValid.value,
      hintText: 'Seu nome completo',
    ),
    fieldStyle: _fieldStyle(viewModel.isNameValid.value),
    colorStyle: AppColors.hintInputForm,
  );

  emailField({required double width}) => FormFieldWidget(
    fieldDecoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(
        color: viewModel.isEmailValid.value
            ? AppColors.white
            : AppColors.delete,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    fieldKey: viewModel.emailKey,
    titleStyle: _titleStyle,
    titleMargin: const EdgeInsets.only(top: 16, bottom: 8),
    title: 'Email',
    isValid: viewModel.isEmailValid.value,
    controller: viewModel.emailController,
    errorText: viewModel.emailErrorText,
    fieldWidth: width,
    isSubmitted: !viewModel.isSubmitted.value,
    inputDecoration: _inputDecoration(
      isValid: viewModel.isEmailValid.value,
      hintText: 'me@company.com',
    ),
    fieldStyle: _fieldStyle(viewModel.isEmailValid.value),
    onChanged: (data) {
      viewModel.formValidation(
        viewModel.emailValidation(data),
        viewModel.isEmailValid,
      );
    },
    colorStyle: AppColors.hintInputForm,
  );

  messageField({required double width}) => FormFieldWidget(
    fieldDecoration: BoxDecoration(
      color: AppColors.white,
      border: Border.all(
        color: viewModel.isMessageValid.value
            ? AppColors.white
            : AppColors.delete,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    fieldKey: viewModel.messageKey,
    titleStyle: _titleStyle,
    title: 'Mensagem',
    isValid: viewModel.isMessageValid.value,
    controller: viewModel.messageController,
    errorText: viewModel.messageErrorText,
    titleMargin: const EdgeInsets.only(top: 16, bottom: 8),
    maxLines: 5,
    maxLength: 500,
    fieldHeight: 115,
    onChanged: (data) {
      viewModel.formValidation(
        !viewModel.isEmptyData(data),
        viewModel.isMessageValid,
      );
    },
    fieldWidth: width,
    isSubmitted: !viewModel.isSubmitted.value,
    fieldStyle: _fieldStyle(viewModel.isMessageValid.value),
    inputDecoration: _inputDecoration(
      isValid: viewModel.isMessageValid.value,
      hintText: 'Sua mensagem...',
      contentPadding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 12,
        //top 8 pra celular
      ),
    ),
    colorStyle: AppColors.hintInputForm,
  );

  _inputDecoration({
    required bool isValid,
    required hintText,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      border: InputBorder.none,
      contentPadding:
          contentPadding ??
          const EdgeInsets.only(
            left: 10,
            right: 10,
            //top 11 pra celular
            top: 12,
          ),
      counterStyle: AppFonts.defaultFont(
        fontSize: 10,
        color: isValid ? const Color(0xff979797) : AppColors.delete,
      ),
      hintStyle: AppFonts.defaultFont(
        fontSize: 14,
        color: isValid ? const Color(0xff979797) : AppColors.delete,
      ),
    );
  }

  _fieldStyle(bool isValid) {
    return AppFonts.defaultFont(
      fontSize: 14,
      color: isValid ? const Color(0xff979797) : AppColors.delete,
    );
  }

  get _titleStyle => AppFonts.defaultFont(fontSize: 14, color: AppColors.grey8);

  sendButton({required double width}) => Container(
    width: width,
    height: 49,
    margin: const EdgeInsets.only(top: 32, bottom: 80),
    child: ButtonWidget(
      shadowColor: AppColors.grey6,
      backgroundColor: viewModel.isSubmitted.value
          ? AppColors.highlightGreen
          : AppColors.darkGreen,
      overlayColor: viewModel.isSubmitted.value
          ? AppColors.highlightGreen
          : AppColors.darkGreen,
      foregroundColor: viewModel.isSubmitted.value
          ? AppColors.grey12
          : AppColors.white,
      action: () {
        viewModel.submit(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(viewModel.isSubmitted.value ? 'Enviado!' : 'Enviar')],
      ),
    ),
  );
}

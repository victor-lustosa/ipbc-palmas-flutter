import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TemplateFormWidget extends StatefulWidget {
  const TemplateFormWidget(
      {super.key,
      required this.controller,
      required this.globalKey,
      required this.errorText,
      required this.isValid,
      this.obscure,
      required this.isPressed,
      required this.title,
      required this.validator,
      required this.inputDecoration,
      this.titleMargin});

  final TextEditingController controller;

  final GlobalKey<FormState> globalKey;

  final String errorText;

  final String title;

  final bool isValid;

  final bool? obscure;

  final bool isPressed;

  final InputDecoration inputDecoration;

  final String? Function(dynamic) validator;

  final EdgeInsetsGeometry? titleMargin;

  @override
  State<TemplateFormWidget> createState() => _TemplateFormWidgetState();
}

class _TemplateFormWidgetState extends State<TemplateFormWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultFormFieldWidget(
      fieldKey: widget.globalKey,
      isSubmitted: !widget.isPressed,
      horizontalSymmetric: const EdgeInsets.symmetric(horizontal: 16),
      fieldMargin: const EdgeInsets.only(top: 4),
      titleMargin: widget.titleMargin,
      fieldDecoration: _fieldDecoration(isValid: widget.isValid),
      title: widget.title,
      isValid: widget.isValid,
      titleStyle: AppFonts.defaultFont(
        fontSize: 13,
        color: AppColors.grey8,
      ),
      controller: widget.controller,
      inputDecoration: widget.inputDecoration,
      obscureText: widget.obscure,
      errorText: widget.errorText,
      fieldHeight: 48,
      validator: widget.validator,
    );
  }

  _fieldDecoration({required isValid}) => BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: isValid ? AppColors.secondaryGrey : Colors.red,
        ),
        borderRadius: BorderRadius.circular(16),
      );
}

fieldInputDecoration(
    {required isValid,
    required hintText,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding}) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    border: InputBorder.none,
    hintStyle: AppFonts.defaultFont(
      fontSize: 12,
      color: isValid ? AppColors.hintInputForm : Colors.red,
    ),
    contentPadding: contentPadding ??
        const EdgeInsets.only(
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

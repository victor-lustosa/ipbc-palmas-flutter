import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  const FieldWidget(
      {super.key,
      required this.controller,
      required this.globalKey,
      required this.errorText,
      required this.isValid,
      this.obscure,
      required this.isPressed,
      required this.title,
      required this.hintText,
      required this.validator,
      required this.inputDecoration, this.titleMargin});

  final TextEditingController controller;

  final GlobalKey<FormState> globalKey;

  final String errorText;

  final String title;

  final String hintText;

  final bool isValid;

  final bool? obscure;

  final bool isPressed;

  final InputDecoration inputDecoration;

  final String? Function(dynamic) validator;

  final EdgeInsetsGeometry? titleMargin;

  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultFieldWidget(
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

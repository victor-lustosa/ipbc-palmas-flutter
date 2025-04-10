import 'package:core_module/core_module.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemplateFormWidget extends StatefulWidget {
  const TemplateFormWidget({
    super.key,
    required this.controller,
    required this.globalKey,
    required this.errorText,
    required this.isValid,
    required this.isPressed,
    required this.validator,
    required this.inputDecoration,
    this.obscure,
    this.title,
    this.inputFormatters,
    this.titleMargin,
    this.maxLines,
    this.fieldHeight,
    this.horizontalSymmetric,
    this.color,
    this.textInputType,
    this.defaultHintColor,
    this.readOnly,
    this.fieldMargin,
    this.valueListenable,
  });

  final int? maxLines;

  final EdgeInsetsGeometry? fieldMargin;

  final bool? readOnly;

  final double? fieldHeight;

  final TextEditingController controller;

  final GlobalKey<FormState> globalKey;

  final String errorText;

  final String? title;

  final bool isValid;

  final bool? obscure;

  final bool isPressed;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? textInputType;

  final InputDecoration inputDecoration;

  final String? Function(dynamic) validator;

  final EdgeInsetsGeometry? titleMargin;

  final EdgeInsetsGeometry? horizontalSymmetric;

  final Color? color;

  final Color? defaultHintColor;

  final ValueListenable<bool>? valueListenable;

  @override
  State<TemplateFormWidget> createState() => _TemplateFormWidgetState();
}

class _TemplateFormWidgetState extends State<TemplateFormWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.valueListenable ?? ValueNotifier(true),
      builder: (_, value, ___) {
        return FormFieldWidget(
          horizontalSymmetric:
              widget.horizontalSymmetric ??
              const EdgeInsets.symmetric(horizontal: 16),
          fieldKey: widget.globalKey,
          isSubmitted: !widget.isPressed,
          fieldMargin: widget.fieldMargin ?? const EdgeInsets.only(top: 4),
          titleMargin: widget.titleMargin,
          fieldDecoration: _fieldDecoration(
            isValid: widget.isValid,
            color: widget.color,
          ),
          title: widget.title,
          isValid: widget.isValid,
          maxLines: widget.maxLines,
          titleStyle: AppFonts.defaultFont(
            fontSize: 13,
            color: AppColors.grey8,
          ),
          inputFormatters: widget.inputFormatters,
          keyboardType: widget.textInputType,
          controller: widget.controller,
          inputDecoration: widget.inputDecoration,
          obscureText: widget.obscure,
          errorText: widget.errorText,
          fieldHeight: widget.fieldHeight ?? 48,
          validator: widget.validator,
          colorStyle: widget.defaultHintColor ?? AppColors.hintInputForm,
        );
      },
    );
  }

  _fieldDecoration({required isValid, Color? color}) => BoxDecoration(
    color: AppColors.white,
    border: Border.all(
      color: color ?? (isValid ? AppColors.secondaryGrey : Colors.red),
    ),
    borderRadius: BorderRadius.circular(16),
  );
}

fieldInputDecoration({
  required bool isValid,
  required hintText,
  Widget? suffixIcon,
  Widget? prefixIcon,
  BoxConstraints? prefixIconConstraints,
  BoxConstraints? suffixIconConstraints,
  Color? hintColor,
  EdgeInsetsGeometry? contentPadding,
}) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    prefixIconConstraints: prefixIconConstraints,
    suffixIconConstraints: suffixIconConstraints,
    border: InputBorder.none,
    hintStyle: AppFonts.defaultFont(
      fontSize: 12,
      color:
          hintColor ?? (isValid ? AppColors.hintInputForm : AppColors.delete),
    ),
    contentPadding:
        contentPadding ?? const EdgeInsets.only(left: 16, bottom: 5, right: 5),
    hintText: hintText,
    counterStyle: AppFonts.defaultFont(
      fontSize: 10,
      color: isValid ? AppColors.hintInputForm : AppColors.delete,
    ),
  );
}

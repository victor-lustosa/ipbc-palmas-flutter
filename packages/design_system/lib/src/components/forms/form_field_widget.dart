import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../design_system.dart';

class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget(
      {super.key,
      required this.validator,
      required this.isValid,
      required this.inputDecoration,
      required this.controller,
      this.fieldKey,
      this.isSubmitted,
      this.maxLength,
      this.fieldStyle,
      this.maxLines,
      this.keyboardType,
      this.cursorColor,
      this.inputFormatters,
      this.autoValidateMode,
      this.title,
      this.titleMargin,
      this.fieldWidth,
      this.fieldHeight,
      this.fieldDecoration,
      this.errorText,
      this.titleStyle,
      this.fieldMargin,
      this.obscureText,
      this.errorTextMargin,
      this.horizontalSymmetric,
      this.inputPadding,
      required this.colorStyle});

  final String? errorText;
  final EdgeInsetsGeometry? errorTextMargin;
  final String? title;
  final EdgeInsetsGeometry? titleMargin;
  final EdgeInsetsGeometry? fieldMargin;
  final Key? fieldKey;
  final TextEditingController controller;
  final bool? isSubmitted;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final bool isValid;
  final TextStyle? titleStyle;
  final Color colorStyle;
  final TextStyle? fieldStyle;
  final double? fieldWidth;
  final double? fieldHeight;
  final BoxDecoration? fieldDecoration;
  final FormFieldValidator validator;
  final InputDecoration inputDecoration;
  final int? maxLines;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final EdgeInsetsGeometry? horizontalSymmetric;
  final EdgeInsetsGeometry? inputPadding;

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.horizontalSymmetric,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title != null,
            child: Container(
              margin: widget.titleMargin,
              child: Text(
                widget.title ?? '',
                style: widget.titleStyle ??
                    AppFonts.defaultFont(
                      fontSize: 16,
                      color: AppColors.grey9,
                    ),
              ),
            ),
          ),
          Container(
            padding: widget.inputPadding,
            margin: widget.fieldMargin,
            width: widget.fieldWidth,
            height: widget.fieldHeight ?? 42,
            decoration: widget.fieldDecoration ??
                BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(
                    color: widget.isValid ? AppColors.white : AppColors.delete,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
            child: TextFormField(
              obscureText: widget.obscureText ?? false,
              key: widget.fieldKey,
              enabled: widget.isSubmitted,
              cursorColor: widget.cursorColor ?? AppColors.formGrey,
              autovalidateMode:
                  widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              validator: widget.validator,
              maxLines: widget.maxLines ?? 1,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              inputFormatters:
                  widget.inputFormatters ?? const <TextInputFormatter>[],
              decoration: widget.inputDecoration,
              style: widget.fieldStyle ??
                  AppFonts.defaultFont(fontSize: 14, color: widget.colorStyle),
            ),
          ),
          Visibility(
            visible: !widget.isValid,
            child: Container(
              margin: widget.errorTextMargin ??
                  const EdgeInsets.only(
                    top: 4,
                    left: 2,
                  ),
              child: Text(
                widget.errorText ?? '',
                style: AppFonts.defaultFont(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

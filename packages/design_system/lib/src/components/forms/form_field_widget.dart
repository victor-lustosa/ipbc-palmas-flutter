import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget(
      {super.key,
      required this.controller,
      this.fieldKey,
      this.isSubmitted,
      this.maxLength,
      this.fieldStyle,
      required this.validator,
      this.maxLines,
      this.keyboardType,
      this.cursorColor,
      this.inputFormatters,
      this.autoValidateMode,
      required this.title,
      this.titleMargin,
      this.fieldWidth,
      this.fieldHeight,
      this.fieldDecoration,
      required this.isValid,
      required this.errorText,
      this.titleStyle,
      this.errorTextMargin,
      required this.inputDecoration,
      this.fieldMargin,
      required this.obscureText});

  final String title;
  final EdgeInsetsGeometry? titleMargin;
  final EdgeInsetsGeometry? fieldMargin;
  final Key? fieldKey;
  final TextEditingController controller;
  final bool? isSubmitted;
  final int? maxLength;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final bool isValid;
  final Text errorText;
  final EdgeInsetsGeometry? errorTextMargin;
  final TextStyle? titleStyle;
  final TextStyle? fieldStyle;
  final double? fieldWidth;
  final double? fieldHeight;
  final BoxDecoration? fieldDecoration;
  final FormFieldValidator validator;
  final InputDecoration inputDecoration;
  final int? maxLines;
  final AutovalidateMode? autoValidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: widget.titleMargin,
          child: Text(
            widget.title,
            style: widget.titleStyle,
          ),
        ),
        Container(
          margin: widget.fieldMargin,
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          decoration: widget.fieldDecoration,
          child: TextFormField(
            obscureText: widget.obscureText,
            key: widget.fieldKey,
            enabled: widget.isSubmitted,
            cursorColor: widget.cursorColor,
            autovalidateMode:
                widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
            controller: widget.controller,
            validator: widget.validator,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            inputFormatters:
                widget.inputFormatters ?? const <TextInputFormatter>[],
            decoration: widget.inputDecoration,
            style: widget.fieldStyle,
          ),
        ),
        Visibility(
          visible: !widget.isValid,
          child: Container(
              margin: widget.errorTextMargin, child: widget.errorText),
        )
      ],
    );
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormFieldWidget extends StatefulWidget {
   const FormFieldWidget(
      {super.key,
      required this.formFieldController,
      required this.hintText,
      this.onChanged,
      this.validator});

  final String? hintText;
  final TextEditingController formFieldController;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      controller: widget.formFieldController,
      keyboardType: TextInputType.text,
      inputFormatters: const <TextInputFormatter>[],
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        focusColor: AppColors.grey0,
        hintText: widget.hintText,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      style: AppFonts.searchField,
    );
  }
}

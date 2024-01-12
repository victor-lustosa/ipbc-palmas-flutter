import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class CustomEmailField extends StatefulWidget {
  final TextEditingController controller;
  final String textLabel;
  final Color borderSideColor;
  final Color inputTextColor;
  final String iconPath;
  final Function(String)? onChanged;

  const CustomEmailField(
      {Key? key,
      required this.controller,
      required this.textLabel,
      required this.borderSideColor,
      required this.iconPath,
      this.onChanged,
      required this.inputTextColor})
      : super(key: key);

  @override
  CustomEmailFieldState createState() => CustomEmailFieldState();
}

class CustomEmailFieldState extends State<CustomEmailField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: TextStyle(
          color: widget.controller.text.isEmpty
              ? AppColors.grey8
              : widget.inputTextColor),
      decoration: InputDecoration(
        hintText: widget.textLabel,
        hintStyle: AppFonts.defaultFont(
            color: AppColors.grey8, fontSize: 12, fontWeight: FontWeight.w400),
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppColors.secondaryGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: widget.borderSideColor),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        suffixIcon: widget.controller.text.isNotEmpty
            ? SizedBox(
                height: 18.95,
                width: 21.65,
                child: Image.asset(
                  widget.iconPath,
                  width: 16,
                  height: 16,
                ),
              )
            : null,
      ),
    );
  }
}

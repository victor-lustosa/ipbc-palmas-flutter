import 'package:flutter/material.dart';

import '../../../design_system.dart';

class CheckBoxCustom extends StatefulWidget {
  final bool isChecked;
  final String textCheckedBox;
  final Color? checkColor;
  final Color? activeColor;
  final Color? fillColor;
  final double? checkedBorder;
  final EdgeInsets? margin;
  final Function(bool) onChanged;

  const CheckBoxCustom({
    Key? key,
    required this.isChecked,
    required this.textCheckedBox,
    required this.onChanged,
    this.checkColor,
    this.activeColor,
    this.fillColor,
    this.checkedBorder,
    this.margin,
  }) : super(key: key);

  @override
  _CheckBoxCustomState createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                checkColor: widget.checkColor ?? AppColors.darkGreen,
                activeColor: widget.activeColor ?? AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(widget.checkedBorder ?? 50),
                ),
                fillColor: MaterialStateProperty.all(
                    widget.fillColor ?? AppColors.white),
                value: widget.isChecked,
                side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(
                    width: 1,
                    color: AppColors.grey2,
                  ),
                ),
                onChanged: (bool? value) {
                  widget.onChanged(value ?? false);
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            widget.textCheckedBox,
            style: AppFonts.defaultFont(
                color: AppColors.grey9,
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

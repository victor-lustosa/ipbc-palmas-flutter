import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class CustomCheckBox extends StatefulWidget {
  final bool isChecked;
  final String textCheckedBox;
  final Color? checkColor;
  final Color? activeColor;
  final Color? fillColor;
  final EdgeInsets? margin;
  final Function(bool) onChanged;
  final TextStyle? textStyle;
  final double? borderRadiusCheckBox;
  final IconData? iconCheckBox;
  final double? sizeIcon;
  final Color? colorBoder;
  final BoxShape? shape;

  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.textCheckedBox,
    required this.onChanged,
    this.checkColor,
    this.activeColor,
    this.fillColor,
    this.margin,
    this.textStyle,
    this.borderRadiusCheckBox,
    this.iconCheckBox,
    this.sizeIcon,
    this.colorBoder,
    this.shape,
  }) : super(key: key);

  @override
  CheckBoxCustomState createState() => CheckBoxCustomState();
}

class CheckBoxCustomState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.all(8),
      child: Row(
        children: [
          SizedBox(
            width: 19,
            height: 19,
            child: Transform.scale(
              scale: 1.2,
              child: InkWell(
                onTap: () {
                  widget.onChanged(!widget.isChecked);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: widget.shape ?? BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(
                        widget.borderRadiusCheckBox ?? 50),
                    border: Border.all(
                      width: 0.8,
                      color: widget.colorBoder ?? AppColors.grey9,
                    ),
                    color: widget.isChecked
                        ? widget.activeColor
                        : widget.fillColor,
                  ),
                  child: widget.isChecked
                      ? Icon(
                          widget.iconCheckBox ?? Icons.circle,
                          size: widget.sizeIcon ?? 14,
                          color: widget.checkColor ?? AppColors.darkGreen,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            widget.textCheckedBox,
            style: widget.textStyle ??
                AppFonts.defaultFont(
                    color: AppColors.grey9,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class SwitchButtonWidget extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchButtonWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SwitchButtonWidget> createState() => _SwitchButtonWidgetState();
}

class _SwitchButtonWidgetState extends State<SwitchButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isOn = widget.value;

    return GestureDetector(
      onTap: () {
        widget.onChanged(!isOn);
      },
      child: SizedBox(
        width: 32, 
        height: 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.grey1,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              left: isOn ? 16 : 0,
              top: 2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: isOn ? AppColors.darkGreen : AppColors.grey5,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

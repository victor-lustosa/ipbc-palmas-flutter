import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ChoiceChipsWidget extends StatefulWidget {
  const ChoiceChipsWidget({super.key});

  @override
  State<ChoiceChipsWidget> createState() => _ChoiceChipsWidgetState();
}

class _ChoiceChipsWidgetState extends State<ChoiceChipsWidget> {
  int _selectedIndex = 0;
  final List<String> _options = ['autor', 'trecho', 'artista'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeOf.width,
      child: Wrap(
        spacing: 12,
        children: List<Widget>.generate(
          _options.length,
          (int index) {
            return ChoiceChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _selectedIndex == index
                      ? AppColors.tabGreen
                      : AppColors.grey4,
                ),
              ),
              showCheckmark: false,
              labelStyle: AppFonts.defaultFont(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: _selectedIndex == index
                    ? AppColors.white
                    : AppColors.grey4,
              ),
              visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
              backgroundColor: AppColors.white,
              selectedColor: AppColors.tabGreen,
              label: Text(_options[index]),
              selected: _selectedIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  _selectedIndex = (selected ? index : null)!;
                });
              },
            );
          },
        ).toList(),
      ),
    );
  }
}

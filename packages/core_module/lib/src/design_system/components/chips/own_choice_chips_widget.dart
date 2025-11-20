import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../stores/search_store.dart';

class OwnChoiceChipsWidget extends StatefulWidget {
  final Function(int)? action;
  final bool? isInitWithoutSelection;
  final bool? hasEmptyOption;
  final List<SearchParameters> options;

  const OwnChoiceChipsWidget({
    super.key,
    this.action,
    this.isInitWithoutSelection,
    this.hasEmptyOption,
    required this.options,
  });

  @override
  State<OwnChoiceChipsWidget> createState() => _OwnChoiceChipsWidgetState();
}

class _OwnChoiceChipsWidgetState extends State<OwnChoiceChipsWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isInitWithoutSelection == true) {
      _selectedIndex = widget.options.length + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeOf.width,
      child: Wrap(
        spacing: 12,
        children: List<Widget>.generate(widget.options.length, (int index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (_selectedIndex == index && widget.hasEmptyOption == true) {
                  _selectedIndex = widget.options.length + 1;
                } else {
                  _selectedIndex = index;
                }
                if(widget.action != null) widget.action!(_selectedIndex);
              });
            },
            child: Container(
              height: 30,
              width: index == 0 ? 75 : 85,
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? AppColors.tabGreen
                    : AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(
                  color: _selectedIndex == index
                      ? AppColors.tabGreen
                      : AppColors.grey4,
                ),
              ),
              child: Center(
                child: Text(
                  widget.options[index].label,
                  style: AppFonts.defaultFont(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: _selectedIndex == index
                        ? AppColors.white
                        : AppColors.grey4,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class OwnChoiceChipsWidget extends StatefulWidget {
  final Function(int)? action;
  final bool? isInitWithoutSelection;
  const OwnChoiceChipsWidget({super.key, this.action, this.isInitWithoutSelection});

  @override
  State<OwnChoiceChipsWidget> createState() => _OwnChoiceChipsWidgetState();
}

class _OwnChoiceChipsWidgetState extends State<OwnChoiceChipsWidget> {
  int _selectedIndex = 0;
  // final List<String> _options = ['título', 'trecho', 'artista'];
  final List<String> _options = ['título', 'artista'];
 @override
  void initState() {
    super.initState();
    if(widget.isInitWithoutSelection != null){
      _selectedIndex = _options.length + 1;
    }
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.sizeOf.width,
      child: Wrap(
        spacing: 12,
        children:
        List<Widget>.generate(_options.length, (int index) {
            return InkWell(
              onTap: () {
                setState(() {
                  if(_selectedIndex == index){
                    _selectedIndex = _options.length + 1;
                  } else {
                    _selectedIndex = widget.action!(index);
                  }
                });
              },
              child: Container(
                height: 30,
                width: index == 0 ? 75 : 85,
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? AppColors.tabGreen
                      : AppColors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  border: Border.all(
                    color: _selectedIndex == index
                        ? AppColors.tabGreen
                        : AppColors.grey4,
                  ),
                ),
                child: Center(
                  child: Text(
                    _options[index],
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
        },
        ).toList(),
      ),
    );
  }
}

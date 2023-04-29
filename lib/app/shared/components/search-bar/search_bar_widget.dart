import 'package:flutter/material.dart';
import '../../../configs/app_configs.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  List<String> searchOptions = ['Trecho', 'Artista', 'Música'];
  String selectedOption = 'Trecho';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(11),
            ),
            color: AppColors.secondLightGrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'Digite o termo de pesquisa',
                  style: AppFonts.bodyPlaceholder,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 36),
                child: SizedBox(
                  height: 48,
                  child: Icon(
                    size: 29.5,
                    Icons.search_sharp,
                    color: Color(0xFF7C7C80),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            height: 48,
            width: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
              color: AppColors.secondLightGrey,
            ),
            child: DropdownWidget(
              searchOptions,
              (String value) {
                setState(
                  () {
                    selectedOption = value;
                  },
                );
              },
              selectedOption,
            ),
          ),
        ),
      ],
    );
  }
}

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(this.list, this.callback, this.initialValue,
      {super.key});

  final Function(String) callback;
  final List<String> list;
  final String initialValue;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _listSelected = '';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(

      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          dropdownColor: AppColors.secondLightGrey,
          elevation: 0,
          iconSize: 34,
          isExpanded: true,
          icon: const Icon(
            Icons.expand_more_outlined,
            color: Color(0xFF7C7C80),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          items: widget.list.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: AppFonts.bodyPlaceholder,
                ),
              );
            },
          ).toList(),
          style: AppFonts.bodyPlaceholder,
          onChanged: (newValue) {
            _dropDownItemSelected(newValue!);
            setState(
              () {
                _listSelected = newValue;
              },
            );
          },
          value: isSelected ? _listSelected : widget.initialValue,
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(
      () {
        _listSelected = novoItem;
        isSelected = true;
        widget.callback(_listSelected);
      },
    );
  }
}

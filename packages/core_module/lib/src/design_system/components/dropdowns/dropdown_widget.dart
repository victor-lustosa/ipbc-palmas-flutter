import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(this.list, this.callback, this.name,
      {super.key, required this.width, required this.height});

  final Function(String) callback;
  final List<String> list;
  final String name;
  final double width;
  final double height;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String _listSelected = '';
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.black45,
          width: 1.0,
          style: BorderStyle.solid,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          //alignedDropdown: true,
          child: DropdownButton<String>(
            elevation: 2,
            isExpanded: true,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            padding: const EdgeInsets.only(
              left: 10,
              right: 7,
            ),
            items: widget.list.map<DropdownMenuItem<String>>(
              (String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(
                    textAlign: TextAlign.left,
                    val,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ).toList(),
            hint: Text(
              widget.name,
              style: const TextStyle(fontSize: 12, color: Colors.black45),
            ),
            style: const TextStyle(fontSize: 12),
            onChanged: (newValue) {
              _dropDownItemSelected(newValue!);
              setState(
                () {
                  _listSelected = newValue;
                },
              );
            },
            value: isSelected ? _listSelected : null,
          ),
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

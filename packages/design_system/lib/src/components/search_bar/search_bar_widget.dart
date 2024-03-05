import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../design_system.dart';
//import '../forms/auth_field_widget.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key, required this.controller,required this.action})
      : super(key: key);

  final TextEditingController controller;
  final void Function() action;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  List<String> searchOptions = ['Trecho', 'Artista', 'Música','banco de dados'];
  String selectedOption = 'Música';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(11),
            ),
            color: AppColors.grey0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 13),
                height: 48,
                width: 192,
                child:
       //FormFieldWidget(
        //            formFieldController: widget.formFieldController,
         //           hintText: 'Digite o termo de pesquisa',
                  //  onChanged: onChangeFormField,
                   // validator: validateFormField),
           //   ),
              SizedBox(
                width: 40,
                child: IconButtonWidget(
                  size: Platform.isIOS ? null : 29.5,
                  color: AppColors.grey9,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iOSIcon: CupertinoIcons.search,
                  androidIcon: Icons.search_sharp,
                  action: widget.action,
                ),
              ),),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Container(
            height: 48,
            width: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(11),
              ),
              color: AppColors.grey0,
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

  //String? onChangeFormField(value) {}
  //String? validateFormField(value) {
  //}

}

class DropdownWidget extends StatefulWidget {
  const DropdownWidget(this.entitiesList, this.callback, this.initialValue,
      {super.key});

  final Function(String) callback;
  final List<String> entitiesList;
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
          dropdownColor: AppColors.grey0,
          elevation: 0,
          iconSize: 34,
          isExpanded: true,
          icon: const Icon(
            Icons.expand_more_outlined,
            color: AppColors.grey9,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          items: widget.entitiesList.map<DropdownMenuItem<String>>(
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

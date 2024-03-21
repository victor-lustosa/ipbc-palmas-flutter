
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget(
      {Key? key, required this.controller, required this.action})
      : super(key: key);

  final TextEditingController controller;
  final void Function() action;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  /*List<String> searchOptions = [
    'Trecho',
    'Artista',
    'Música',
    'banco de dados'
  ];
  String selectedOption = 'Música';*/
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 19,
      ),
      child: FormFieldWidget(
        fieldHeight: 48,
        fieldWidth: context.mediaQuery.size.width,
        controller: widget.controller,
        fieldDecoration: BoxDecoration(
          color: AppColors.searchBar,
          border: Border.all(
            color: AppColors.secondaryGrey,
          ),
          borderRadius: BorderRadius.circular(11),
        ),
        isValid: isValid,
        validator: (value) => null,
        inputDecoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () {},
            child: IconButtonWidget(
              size: 28,
              color: AppColors.grey7,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iOSIcon: CupertinoIcons.search,
              androidIcon: Icons.search_sharp,
              action: widget.action,
            ),
          ),
          border: InputBorder.none,
          hintStyle: AppFonts.defaultFont(
            fontSize: 12,
            color: AppColors.grey5,
          ),
          contentPadding: const EdgeInsets.only(
            left: 16,
            top: 10,
          ),
          hintText: 'Digite o termo de pesquisa',
        ),
      ),
    );
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class GenericErrorView extends StatefulWidget {
  const GenericErrorView({super.key});

  @override
  State<GenericErrorView> createState() => _GenericErrorViewState();
}

class _GenericErrorViewState extends State<GenericErrorView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.mediaQuery.size.width,
      height: context.mediaQuery.size.height * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(
              Icons.error_outline_outlined,
              size: 50,
              color: Colors.red,
            ),
          ),
          Center(
            child: Container(
              width: 226.31,
              margin: const EdgeInsets.only(top: 30, bottom: 59.8),
              child: Text(
                "Ops! Ocorreu um erro no Sistema.",
                style: AppFonts.defaultFont(
                  color: AppColors.grey12,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

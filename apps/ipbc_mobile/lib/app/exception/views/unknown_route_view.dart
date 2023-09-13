import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class UnknownRouteView extends StatefulWidget {
  const UnknownRouteView({super.key});

  @override
  State<UnknownRouteView> createState() => _UnknownRouteViewState();
}

class _UnknownRouteViewState extends State<UnknownRouteView> {
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
              Icons.not_listed_location_outlined,
              size: 40,
              color: Colors.red,
            ),
          ),
          Center(
            child: Container(
              width: 226.31,
              margin: const EdgeInsets.only(top: 30, bottom: 59.8),
              child: Text(
                "Ops! Rota não encontrada.",
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

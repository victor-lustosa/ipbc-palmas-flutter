import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceTopBarWidget extends StatefulWidget {
  const ServiceTopBarWidget({super.key, required this.entity});

  final ServicesEntity entity;

  @override
  State<ServiceTopBarWidget> createState() => _ServiceTopBarWidgetState();
}

class _ServiceTopBarWidgetState extends State<ServiceTopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 186,
      width: context.mediaQuery.size.width,
      decoration: BoxDecoration(
        color: AppColors.grey4,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            widget.entity.image,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          left: 5,
          right: 8,
          bottom: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BackButtonWidget(
                      action: () => Navigator.pop(context),
                    ),
                    Text(
                      "Cultos de ${widget.entity.heading}",
                      style: AppFonts.defaultFont(
                          color: AppColors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

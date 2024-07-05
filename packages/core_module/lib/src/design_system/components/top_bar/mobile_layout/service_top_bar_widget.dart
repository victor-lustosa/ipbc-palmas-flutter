import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceTopBarWidget extends StatefulWidget {
  const ServiceTopBarWidget({
    super.key,
    required this.image,
    this.title,
    this.dateIsVisible,
    this.createAt,
  });

  final String image;
  final String? title;
  final bool? dateIsVisible;
  final String? createAt;

  @override
  State<ServiceTopBarWidget> createState() => _ServiceTopBarWidgetState();
}

class _ServiceTopBarWidgetState extends State<ServiceTopBarWidget> {
  get dateIsVisible => (widget.dateIsVisible ?? false);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 184,
      width: context.sizeOf.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            widget.image,
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 17,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: dateIsVisible
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16.3,
                        right: 16,
                      ),
                      child: BackButtonWidget(
                        color: AppColors.white,
                        action: () => nativePop(context),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.title ?? '',
                        style: AppFonts.defaultFont(
                            color: AppColors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),

                Visibility(
                  visible: dateIsVisible,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.badgeGreen,
                      borderRadius: BorderRadius.all(
                        Radius.circular(34.7),
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      right: 15,

                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                        bottom: 4,
                        top: 4,
                      ),
                      child: Text(
                        widget.createAt ?? '',
                        style: AppFonts.defaultFont(
                          color: const Color(0xFF005B40),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

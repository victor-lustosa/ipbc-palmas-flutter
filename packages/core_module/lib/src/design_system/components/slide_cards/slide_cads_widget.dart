import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class SlideCardsWidget extends StatefulWidget {
  final List entities;
  final String route;
  final double width;
  final EdgeInsetsGeometry? margin;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool? shrinkWrap;

  const SlideCardsWidget({
    required this.entities,
    required this.scrollDirection,
    super.key,
    required this.route,
    required this.width,
    this.physics,
    this.margin,
    this.shrinkWrap,
  });

  @override
  State<SlideCardsWidget> createState() => SlideCardsWidgetState();
}

class SlideCardsWidgetState extends State<SlideCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: widget.shrinkWrap ?? true,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      itemCount: widget.entities.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Modular.get<AppGlobalKeys>().resetAuthAvatarKey();
            nativePushNamed(
              widget.route,
              arguments: widget.entities[index],
              context,
            );
          },
          child: Container(
            margin:
                widget.margin ??
                EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
            child: Column(
              children: [
                Container(
                  width: widget.width,
                  height: 144,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(1, 2),
                        color: AppColors.grey2,
                      ),
                    ],
                    color: AppColors.grey4,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(0, 66, 46, 0.40),
                        BlendMode.color,
                      ),
                      image: NetworkImage(widget.entities[index].image),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.entities[index].title,
                      style: AppFonts.defaultFont(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: widget.width,
                  height: 101,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(4, 4),
                        color: AppColors.grey2,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: Row(
                            children: [
                              Text(
                                'Ter, 10 de Outubro',
                                style: AppFonts.defaultFont(
                                  color: AppColors.darkGreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 5,
                                  top: 1,
                                  right: 5,
                                ),
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.darkGreen,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Text(
                                '16h',
                                style: AppFonts.defaultFont(
                                  color: AppColors.darkGreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.entities[index].subtitle,
                                style: AppFonts.defaultFont(
                                  color: AppColors.grey12,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 20,
                                child: const Image(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(AppIcons.iosShare),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                width: 11,
                                child: const Image(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(AppIcons.locationOn),
                                ),
                              ),
                              Text(
                                widget.entities[index].localName,
                                style: AppFonts.defaultFont(
                                  color: AppColors.grey8,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

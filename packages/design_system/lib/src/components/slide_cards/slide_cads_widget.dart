import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class SlideCardsWidget extends StatefulWidget {
  final List<ServicesEntity> services;
  final String route;
  final double width;
  final EdgeInsetsGeometry? margin;
  final ScrollPhysics? physics;
  final Axis scrollDirection;

  const SlideCardsWidget({
    required this.services,
    required this.scrollDirection,
    Key? key,
    required this.route,
    required this.width,
    this.physics,
    this.margin,
  }) : super(key: key);

  @override
  State<SlideCardsWidget> createState() => SlideCardsWidgetState();
}

class SlideCardsWidgetState extends State<SlideCardsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            widget.route,
            arguments: widget.services[index],
          ),
          child: Container(
            margin: widget.margin ??
                EdgeInsets.only(
                  left: index == 0 ? 16 : 0,
                  right: 16,
                ),
            child: Column(
              children: [
                Container(
                  width: widget.width,
                  height: 144,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(5, 5),
                        color: AppColors.grey2,
                      )
                    ],
                    color: AppColors.grey4,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color.fromRGBO(0, 66, 46, 0.40),
                        BlendMode.color,
                      ),
                      image: AssetImage(AppImages.familyDayImage),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Dia da Família',
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
                        blurRadius: 18,
                        spreadRadius: 1,
                        offset: Offset(8, 8),
                        color: AppColors.grey2,
                      )
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
                                'Dia da família IPBC Palmas',
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
                                  image: AssetImage(
                                    AppIcons.iosShare,
                                  ),
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
                                  image: AssetImage(
                                    AppIcons.locationOn,
                                  ),
                                ),
                              ),
                              Text(
                                'Parque Casamar',
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

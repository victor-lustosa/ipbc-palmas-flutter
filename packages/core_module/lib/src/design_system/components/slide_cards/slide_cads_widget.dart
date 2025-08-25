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
  final void Function(LongPressStartDetails)? onLongPressStart;

  const SlideCardsWidget({
    this.onLongPressStart,
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
  late final SlideCardsStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<SlideCardsStore>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap ?? false,
      itemCount: widget.entities.length,
      cacheExtent: 1000,
      itemBuilder: (BuildContext context, int index) {
        final GlobalKey itemKey = GlobalKey();
        final entity = widget.entities[index];
        return GestureDetector(
          key: itemKey,
          onLongPressStart: (details) async {
            _store.index = index;
            _store.itemKey = itemKey;
            _store.eventEntity = entity;
            widget.onLongPressStart?.call(details);
          },
          child: InkWell(
            onTap: () {
              nativePushNamed(widget.route, arguments: entity, context);
            },
            child: Container(
              width: widget.width,
              margin:
                  widget.margin ??
                  EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: entity.image,
                      height: 144,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: AppColors.grey4),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      color: const Color.fromRGBO(0, 66, 46, 0.40),
                      colorBlendMode: BlendMode.color,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(2, 4),
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: AppColors.grey2.withAlpha(153),
                            ),
                          ],
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Color.fromRGBO(0, 66, 46, 0.40),
                              BlendMode.color,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            entity.title,
                            style: AppFonts.defaultFont(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 12),
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
                                entity.subtitle,
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
                          margin: const EdgeInsets.only(top: 4, bottom: 16),
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
                                entity.localName,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

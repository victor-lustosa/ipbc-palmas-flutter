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
  final AnimationController shimmerController;
  final void Function(LongPressStartDetails)? onLongPressStart;
  final Function()? action;

  const SlideCardsWidget({
    this.onLongPressStart,
    required this.shimmerController,
    required this.entities,
    required this.scrollDirection,
    super.key,
    required this.route,
    required this.width,
    this.physics,
    this.margin,
    this.shrinkWrap,
    this.action,
  });

  @override
  State<SlideCardsWidget> createState() => SlideCardsWidgetState();
}

class SlideCardsWidgetState extends State<SlideCardsWidget> with DateMixin {
  late final SlideCardsStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<SlideCardsStore>();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallDevice = ResponsivityUtil.isSmallDevice(context);
    bool isHorizontal = widget.scrollDirection == Axis.horizontal;
    Widget placeholder({child, border}) => ShimmerWidget(
      animation: widget.shimmerController,
      child:
          child ??
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: border ?? BorderRadius.circular(12),
            ),
          ),
    );
    return widget.entities.isEmpty
        ? placeholder(
            child: ListView.builder(
              shrinkWrap: widget.shrinkWrap ?? false,
              scrollDirection: widget.scrollDirection,
              physics: widget.physics,
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                margin: isHorizontal
                    ? const EdgeInsets.only(left: 16)
                    : const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                height: isHorizontal
                    ? (isSmallDevice
                          ? context.sizeOf.width * .48
                          : context.sizeOf.width * .48)
                    : (isSmallDevice
                          ? context.sizeOf.width * 0.6
                          : context.sizeOf.width * 0.6),
                width: widget.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          )
        : ListView.builder(
            scrollDirection: widget.scrollDirection,
            physics: widget.physics,
            shrinkWrap: widget.shrinkWrap ?? false,
            itemCount: widget.entities.length,
            cacheExtent: 1000,
            itemBuilder: (BuildContext context, int index) {
              bool isSmallDevice = ResponsivityUtil.isSmallDevice(context);
              final GlobalKey itemKey = GlobalKey();
              final EventEntity entity = widget.entities[index];
              return GestureDetector(
                key: itemKey,
                onTap: widget.action != null ?(){
                  _store.eventEntity = entity;
                  widget.action!();
                }: () {
                  pushNamed(widget.route, arguments: entity);
                },
                onLongPressStart: (details) async {
                  _store.index = index;
                  _store.itemKey = itemKey;
                  _store.eventEntity = entity;
                  widget.onLongPressStart?.call(details);
                },
                child: Container(
                  width: widget.width,
                  margin:
                      widget.margin ??
                      EdgeInsets.only(left: index == 0 ? 16 : 0, right: 16),
                  height: isHorizontal
                      ? (isSmallDevice
                            ? context.sizeOf.width * .60
                            : context.sizeOf.width * .60)
                      : null,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: entity.image,
                          height: context.sizeOf.width * .335,
                          width: context.sizeOf.width,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => placeholder(
                            border: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          errorWidget: (context, url, error) => placeholder(
                            border: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
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
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  entity.title,
                                  textAlign: TextAlign.center,
                                  style: AppFonts.defaultFont(
                                    fontSize: isSmallDevice ? 18 : 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
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
                              margin: EdgeInsets.only(
                                top: isSmallDevice ? 11 : 16,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    maxLines: 1,
                                    getFormattedDateTimeFull(
                                      entity.startDateTime,
                                    ),
                                    style: AppFonts.defaultFont(
                                      color: AppColors.darkGreen,
                                      fontSize: isSmallDevice ? 14 : 15,
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
                                    formatHourToString(
                                      date: entity.startDateTime,
                                    ),
                                    style: AppFonts.defaultFont(
                                      color: AppColors.darkGreen,
                                      fontSize: isSmallDevice ? 14 : 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: isSmallDevice ? 6 : 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        right: isSmallDevice ? 14 : 10,
                                      ),
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        entity.subtitle,
                                        style: AppFonts.defaultFont(
                                          color: AppColors.grey12,
                                          fontSize: isSmallDevice ? 15 : 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: isSmallDevice ? 7 : 12,
                                    ),
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
                              margin: EdgeInsets.only(
                                top: 4,
                                bottom: isSmallDevice ? 11 : 16,
                              ),
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
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        entity.localName ?? '',
                                        style: AppFonts.defaultFont(
                                          color: AppColors.grey8,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
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
              );
            },
          );
  }
}

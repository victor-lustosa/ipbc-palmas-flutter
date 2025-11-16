import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class SlideCardsWidget extends StatefulWidget {
  final List entities;
  final String route;
  final double width;
  final EdgeInsetsGeometry? margin;
  final ScrollPhysics? physics;
  final Axis scrollDirection;
  final bool? shrinkWrap;
  final bool isLoading;
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
    required this.isLoading,
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

  Widget _buildCardItem(BuildContext context, int index) {
    bool isSmallDevice = ResponsivityUtil.isSmallDevice(context);
    final GlobalKey itemKey = GlobalKey();
    final EventEntity entity = widget.entities[index];
    return GestureDetector(
      key: itemKey,
      onTap: widget.action != null
          ? () {
              _store.eventEntity = entity;
              widget.action!();
            }
          : () {
              pushNamed(widget.route, arguments: entity);
            },
      onLongPressStart: (details) async {
        _store.index = index;
        _store.itemKey = itemKey;
        _store.eventEntity = entity;
        widget.onLongPressStart?.call(details);
      },
      child: SizedBox(
        width: widget.width,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: entity.image,
                height: context.sizeOf.width * .35,
                width: context.sizeOf.width,
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
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(

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
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    spreadRadius: 1,
                    offset: Offset(3, 3),
                    color: AppColors.grey2.withAlpha(150),
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
                    margin: EdgeInsets.only(top: isSmallDevice ? 11 : 16),
                    child: Row(
                      children: [
                        Text(
                          maxLines: 1,
                          getFormattedDateTimeFull(entity.startDateTime),
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
                          formatHourToString(date: entity.startDateTime),
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
                    margin: EdgeInsets.only(top: isSmallDevice ? 6 : 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }

  Widget _buildPlaceholder(
    BuildContext context,
    bool isHorizontal,
    shrinkWrap,
  ) {
    Widget shimmerWrapper = ListView.builder(
      shrinkWrap: !isHorizontal,
      scrollDirection: widget.scrollDirection,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        margin: isHorizontal
            ? const EdgeInsets.only(left: 16)
            : const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        width: widget.width,
        height: isHorizontal
            ? null
            : context.sizeOf.width * .56,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );

    if (isHorizontal) {
      return placeholder(
        child: SizedBox(
          height: context.sizeOf.width * .585,
          child: shimmerWrapper,
        ),
      );
    } else {
      return placeholder(child: shimmerWrapper);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = widget.scrollDirection == Axis.horizontal;
    bool isLoading = widget.isLoading && widget.entities.isEmpty;
    Widget emptyList = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          width: 26,
          height: 26,
          child: Image.asset(AppIcons.info, color: Colors.blueAccent),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          width: context.sizeOf.width * .6,
          child: Text(
            textAlign: TextAlign.center,
            style: AppFonts.defaultFont(fontSize: ResponsivityUtil<double>(sm: 13, xl: 14).get(context), color: AppColors.grey9),
            'Não há eventos cadastrados no momento.',
          ),
        ),
      ],
    );
    if (widget.scrollDirection == Axis.horizontal) {
      return isLoading
          ? _buildPlaceholder(context, isHorizontal, widget.shrinkWrap)
          : !widget.isLoading && widget.entities.isEmpty
          ? emptyList
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.entities.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 16,
                      bottom: 10,
                      left: index == 0 ? 16 : 0,
                    ),
                    child: _buildCardItem(context, index),
                  );
                }),
              ),
            );
    } else {
      return isLoading
          ? _buildPlaceholder(context, isHorizontal, widget.shrinkWrap)
          : !widget.isLoading && widget.entities.isEmpty
          ? Container(
              margin: EdgeInsets.only(top: context.sizeOf.height * .15),
              child: emptyList,
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: widget.shrinkWrap ?? false,
              scrollDirection: widget.scrollDirection,
              itemCount: widget.entities.length,
              cacheExtent: 1000,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: index == widget.entities.length - 1 ? 0 : 16,
                    left: 16,
                    right: 16,
                  ),
                  child: _buildCardItem(context, index),
                );
              },
            );
    }
  }
}

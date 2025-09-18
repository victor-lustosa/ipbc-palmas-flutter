import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ServiceTopBarWidget extends StatefulWidget {
  const ServiceTopBarWidget({
    super.key,
    required this.image,
    this.title,
    this.dateIsVisible,
    this.createAt,
    this.backAction,
  });

  final String image;
  final String? title;
  final bool? dateIsVisible;
  final String? createAt;
  final void Function()? backAction;
  
  @override
  State<ServiceTopBarWidget> createState() => _ServiceTopBarWidgetState();
}

class _ServiceTopBarWidgetState extends State<ServiceTopBarWidget>
    with TickerProviderStateMixin {
  get dateIsVisible => (widget.dateIsVisible ?? false);
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallDevice =
        context.sizeOf.width > ResponsivityUtil.smallDeviceWidth;
    Widget placeholder({child}) => ShimmerWidget(
      animation: _shimmerController,
      child:
          child ??
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
    );
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.image,
        height: 184,
        width: context.sizeOf.width,
        fit: BoxFit.cover,
        placeholder: (context, url) => placeholder(),
        errorWidget: (context, url, error) => placeholder(),
        color: const Color.fromRGBO(0, 66, 46, 0.40),
        colorBlendMode: BlendMode.color,
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
          child: Container(
            margin: const EdgeInsets.only(bottom: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: isSmallDevice ? 16 : 10,
                          right: isSmallDevice ? 16 : 10,
                        ),
                        child: BackButtonWidget(
                          color: AppColors.white,
                          size: isSmallDevice ? 30 : 26,
                          action: widget.backAction ?? () => nativePop(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: dateIsVisible
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              widget.title ?? '',
                              style: AppFonts.defaultFont(
                                fontSize: isSmallDevice ? 18 : 16,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                              margin: EdgeInsets.only(
                                right: isSmallDevice ? 16 : 10,
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
                                    fontSize: isSmallDevice ? 13 : 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

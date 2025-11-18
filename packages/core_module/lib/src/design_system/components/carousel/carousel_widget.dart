import 'package:core_module/core_module.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  final List<ServicesEntity> services;
  final double width;
  final double? height;
  final String? route;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? fontStyle;
  final AnimationController? shimmerController;

  const CarouselWidget({
    required this.services,
    required this.width,
    this.shimmerController,
    this.height,
    super.key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.fontStyle,
    this.padding,
    this.margin,
    this.route,
  });

  @override
  State<CarouselWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;
  int activePage = 0;
  ValueNotifier<bool> imageHasLoaded = ValueNotifier(false);
  final Map<int, bool> _isImageLoaded = {};

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget selectionIndicator = Visibility(
      visible: widget.services.isNotEmpty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(widget.services.length, (index) {
          return Container(
            margin: const EdgeInsets.only(top: 3, left: 2, right: 2, bottom: 3),
            width: activePage == index ? 8 : 4,
            height: activePage == index ? 8 : 4,
            decoration: BoxDecoration(
              color: activePage == index
                  ? AppColors.highlightGreen
                  : const Color(0xFFCCCCCC),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );

    Widget placeholder({child}) => ShimmerWidget(
      animation: widget.shimmerController!,
      child:
          child ??
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
    );

    carousel() => Container(
      margin: widget.margin,
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        itemCount: widget.services.length,
        controller: _pageController,
        onPageChanged: (page) {
          setState(() {
            activePage = page;
          });
        },
        itemBuilder: (context, position) {
          bool active = position == activePage;
          imageHasLoaded.value = _isImageLoaded[position] ?? false;
          return InkWell(
            onTap:
                widget.route == null ||
                    widget.services.isEmpty ||
                    !imageHasLoaded.value
                ? null
                : () => nativePushNamed(
                    widget.route!,
                    arguments: widget.services[position],
                    context,
                  ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              margin: EdgeInsets.only(
                top: active ? 8 : 10,
                bottom: active ? 8 : 10,
                left: active ? 10 : 3,
                right: active ? 10 : 3,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(40),
                boxShadow:
                    (kIsWeb || widget.services.isEmpty || !imageHasLoaded.value)
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.grey.withAlpha(100),
                          offset: const Offset(1, 1),
                          spreadRadius: 2,
                          blurRadius: 7,
                        ),
                      ],
                borderRadius: BorderRadius.all(
                  kIsWeb ? Radius.circular(20) : Radius.circular(16),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  kIsWeb ? Radius.circular(20) : Radius.circular(16),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.services[position].image,
                      imageBuilder: (context, imageProvider) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted && !imageHasLoaded.value) {
                            Future.delayed(Duration(milliseconds: 300), () {
                              setState(() {
                                _isImageLoaded[position] = true;
                                imageHasLoaded.value = true;
                              });
                            });
                          }
                        });
                        return Image(image: imageProvider, fit: BoxFit.cover);
                      },
                      placeholder: (context, url) => placeholder(),
                      errorWidget: (context, url, error) => placeholder(),
                    ),
                    Container(
                      margin: kIsWeb
                          ? EdgeInsets.only(left: 16, bottom: 16)
                          : EdgeInsets.zero,
                      child: Column(
                        mainAxisAlignment:
                            widget.mainAxisAlignment ?? MainAxisAlignment.start,
                        crossAxisAlignment:
                            widget.crossAxisAlignment ??
                            CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.services.isEmpty
                                ? ''
                                : widget.services[position].title,
                            style: widget.fontStyle,
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
      ),
    );

    return kIsWeb
        ? Column(
            children: [
              carousel(),
              selectionIndicator,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(
                    image: AppIcons.arrowBackDarkGreen,
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOutCubic,
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 45),
                    child: button(
                      image: AppIcons.arrowForwardDarkGreen,
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column(
            children: [
              AspectRatio(
                aspectRatio: 344 / 163,
                child: widget.services.isEmpty
                    ? placeholder(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      )
                    : carousel(),
              ),
              selectionIndicator,
            ],
          );
  }

  button({required String image, required VoidCallback onPressed}) =>
      SizedBox(
    width: 35,
    height: 35,
    child: IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Image.asset(image),
    ),
  );
}

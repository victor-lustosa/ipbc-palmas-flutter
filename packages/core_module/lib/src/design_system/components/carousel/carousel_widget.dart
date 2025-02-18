import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class CarouselWidget extends StatefulWidget {
  final List<ServicesEntity> services;
  final double width;
  final double height;
  final String? route;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? fontStyle;

  const CarouselWidget({
    required this.services,
    required this.width,
    required this.height,
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
  static late PageController _pageController;

  int activePage = 0;
  final List<Image> imagesList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.services.length; i++) {
      imagesList.add(Image.network(widget.services[i].image));
    }
    _pageController = PageController(initialPage: 0);
  }

  @override
  void didChangeDependencies() {
    for (Image image in imagesList) {
      precacheImage(image.image, context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
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
              return InkWell(
                onTap:
                    widget.route == null
                        ? () {}
                        : () => nativePushNamed(
                          widget.route!,
                          arguments: widget.services[position],
                          context,
                        ),
                child: AnimatedContainer(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.only(
                    top: active ? 10 : 14,
                    bottom: active ? 10 : 14,
                    left: active ? 10 : 3,
                    right: active ? 10 : 3,
                  ),
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    color: AppColors.grey4,
                    boxShadow:
                        kIsWeb
                            ? []
                            : [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 102),
                                offset: const Offset(1, 1),
                                spreadRadius: 3,
                                blurRadius: 7,
                              ),
                            ],
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imagesList[position].image,
                    ),
                  ),
                  curve: Curves.easeInOutCubic,
                  child: InkWell(
                    child: Column(
                      mainAxisAlignment:
                          widget.mainAxisAlignment ?? MainAxisAlignment.start,
                      crossAxisAlignment:
                          widget.crossAxisAlignment ??
                          CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.services[position].title,
                          style: widget.fontStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(widget.services.length, (index) {
            return Container(
              margin: const EdgeInsets.only(
                top: 3,
                left: 2,
                right: 2,
                bottom: 3,
              ),
              width: activePage == index ? 8 : 4,
              height: activePage == index ? 8 : 4,
              decoration: BoxDecoration(
                color:
                    activePage == index
                        ? AppColors.highlightGreen
                        : const Color(0xFFCCCCCC),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        Visibility(
          visible: kIsWeb,
          child: Row(
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
        ),
      ],
    );
  }

  button({required String image, required VoidCallback onPressed}) => SizedBox(
    width: 50,
    height: 50,
    child: IconButton(onPressed: onPressed, icon: Image.asset(image)),
  );
}

import 'package:flutter/material.dart';

import '../../../design_system.dart';

class CarouselWidget extends StatefulWidget {
  final List<Map<String, String>> services;
  final double width;
  final double height;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? fontStyle;

  const CarouselWidget({
    required this.services,
    required this.width,
    required this.height,
    Key? key,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.fontStyle, this.padding,
  }) : super(key: key);

  @override
  State<CarouselWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  static late PageController _pageController;
  int activePage = 0;
  final List<Image> imagesList = [];
  static get pageController => _pageController;
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.services.length; i++) {
      imagesList.add(Image.network(widget.services[i]['path']!,));
    }
    _pageController = PageController(
      initialPage: 0,
    );
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
    return Column(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.services.length,
            controller: _pageController,
            onPageChanged: (page) {
              setState(
                () {
                  activePage = page;
                },
              );
            },
            itemBuilder: (context, position) {
              bool active = position == activePage;
              return AnimatedContainer(
                padding: widget.padding ?? EdgeInsets.zero,
                margin: EdgeInsets.all(active ? 0 : 6),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: AppColors.grey4,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imagesList[position].image,
                  ),
                ),
                curve: Curves.easeInOutCubic,
                child: Column(
                  mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
                  crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.services[position]['label']!,
                      style: widget.fontStyle,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              widget.services.length,
              (index) {
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
                    color: activePage == index
                        ? AppColors.highlightGreen
                        : const Color(0xFFCCCCCC),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

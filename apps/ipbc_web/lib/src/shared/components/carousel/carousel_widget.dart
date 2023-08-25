import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../home/components/about_services_widget.dart';

class CarouselWidget extends StatefulWidget {
  final List<AboutServices> services;
  final double width;
  final double height;

  const CarouselWidget({
    required this.services,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      //viewportFraction: 0.8,
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.services.length,
            // pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(
                () {
                  activePage = page;
                },
              );
            },
            itemBuilder: (context, pagePosition) {
              bool active = pagePosition == activePage;
              return AnimatedContainer(
                padding: const EdgeInsets.only(
                  left: 26,
                  right: 16,
                  bottom: 16,
                ),
                margin: EdgeInsets.all(active ? 0 : 15),
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      widget.services[pagePosition].imagePath,
                    ),
                  ),
                ),
                curve: Curves.easeIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.services[pagePosition].label,
                      style: AppFonts.defaultFont(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffffffff),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        widget.services.length,
                        (index) {
                          return Container(
                            margin: const EdgeInsets.only(
                              top: 6,
                              left: 4,
                              right: 4,
                            ),
                            width: activePage == index ? 8 : 4,
                            height: activePage == index ? 8 : 4,
                            decoration: BoxDecoration(
                              color: activePage == index
                                  ? AppColors.highlightGreen
                                  : AppColors.grey0,
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 18),
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
        child: IconButton(
          onPressed: onPressed,
          icon: Image.asset(image),
        ),
      );
}

/*import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../home/components/about_services_widget.dart';

class CarouselWidget extends StatefulWidget {
  final List<AboutServices> services;

  const CarouselWidget({
    required this.services,
    Key? key,
  }) : super(key: key);

  @override
  State<CarouselWidget> createState() => CarouselWidgetState();
}

class CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      //viewportFraction: 0.8,
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 442,
          height: 422,
          child: PageView.builder(
            itemCount: widget.services.length,
            // pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(
                () {
                  activePage = page;
                },
              );
            },
            itemBuilder: (context, pagePosition) {
              bool active = pagePosition == activePage;
              return AnimatedContainer(
                padding: const EdgeInsets.only(
                  left: 26,
                  top: 370,
                  right: 16,
                  bottom: 16,
                ),
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.all(active ? 0 : 15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      widget.services[pagePosition].imagePath,
                    ),
                  ),
                ),
                curve: Curves.easeInOutCubic,
                child: Text(
                  widget.services[pagePosition].label,
                  style: AppFonts.defaultFont(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffffffff),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            widget.services.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 6,
                  left: 4,
                  right: 4,
                ),
                width: activePage == index ? 8 : 4,
                height: activePage == index ? 8 : 4,
                decoration: BoxDecoration(
                  color: activePage == index
                      ? AppColors.highlightGreen
                      : AppColors.grey0,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 57,
              height: 57,
              child: IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  icon: Image.asset(AppIcons.arrowBackDarkGreen)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 45),
              width: 57,
              height: 57,
              child: IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  icon: Image.asset(AppIcons.arrowForwardDarkGreen)),
            )
          ]),
        ),
      ],
    );
  }
}
*/

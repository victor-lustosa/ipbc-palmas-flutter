import 'package:flutter/material.dart';
import '../../../configs/app_configs.dart';

class Carousel extends StatefulWidget {
  final List<String> images;

  const Carousel({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => CarouselState();
}

class CarouselState extends State<Carousel> {
  late PageController _pageController;

  int activePage = 1;

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
          //  decoration:
          //      BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
            itemCount: widget.images.length,
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
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.all(active ? 0 : 15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                // curve: Curves.easeInOutCubic,
                child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: InkWell(
                          splashColor: Colors.black26,
                          onTap: () {},
                          child: Column(
                            children: const [
                              // Ink.image(image: NetWorkingImage(widget.images[pagePosition]))
                            ],
                          ),
                        ))),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            widget.images.length,
            (index) {
              return Container(
                margin: const EdgeInsets.only(
                  top: 6,
                  left: 3,
                  right: 3,
                ),
                width: activePage == index ? 8 : 4,
                height: activePage == index ? 8 : 4,
                decoration: BoxDecoration(
                  color: activePage == index
                      ? const Color(0xFF00E8A2)
                      : AppColors.secondLightGrey,
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key, required this.entities, required this.shimmerController});
  final AnimationController shimmerController;
  final List<ServicesEntity> entities;

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView>
    with DateMixin {

  double proportion = 343/92;

  @override
  Widget build(BuildContext context) {
    Widget placeholder() => ShimmerWidget(
      animation: widget.shimmerController,
      child: AspectRatio(
        aspectRatio: proportion,
        child: Container(
          width: context.sizeOf.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
    return Builder(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BackAuthTopBarWidget(
                    action: () => nativePop(context),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text("Cultos", style: AppFonts.title2),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, top: 8, right: 20),
                      child: Text(
                        "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                        style: AppFonts.defaultFont(
                          fontSize: 15,
                          height: 1.2,
                          color: AppColors.grey9,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 28, left: 16, right: 16),
                    width: context.sizeOf.width,
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 16);
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: widget.entities.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            nativePushReplacementNamed(
                              AppRoutes.servicesCollectionRoute,
                              arguments: widget.entities[index],
                              context,
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: widget.entities[index].image,
                            placeholder: (context, url) => placeholder(),
                            errorWidget: (context, url, error) => placeholder(),
                            imageBuilder: (context, imageProvider) => AspectRatio(
                              aspectRatio: proportion,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(
                                      Color.fromRGBO(0, 66, 46, 0.40),
                                      BlendMode.color,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      child: Text(
                                        '${widget.entities[index].title} | ${formatHourToString(date: widget.entities[index].serviceDate)}',
                                        style: AppFonts.headline(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      child: const IconButtonWidget(
                                        sizeIcon: 23,
                                        iconFormat: IconFormat.svg,
                                        color: AppColors.white,
                                        iconPath: AppIcons.arrowForward,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

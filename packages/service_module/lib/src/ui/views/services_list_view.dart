import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key, required this.entities});
  final List<ServicesEntity> entities;

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> with DateMixin, TickerProviderStateMixin {

  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  @override
  dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget placeholder() =>
        ShimmerWidget(animation: _shimmerController, child: Container(
          height: 110,
          width: context.sizeOf.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
        ));
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
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>placeholder(),
                        errorWidget: (context, url, error) =>placeholder(),
                        color: const Color.fromRGBO(0, 66, 46, 0.40),
                        colorBlendMode: BlendMode.color,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 110,
                          width: context.sizeOf.width,
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
                                margin: const EdgeInsets.only(right: 5),
                                child: const IconButtonWidget(
                                  size: 34,
                                  color: AppColors.white,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  iOSIcon: CupertinoIcons.chevron_forward,
                                  androidIcon: Icons.navigate_next_sharp,
                                ),
                              ),
                            ],
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
}

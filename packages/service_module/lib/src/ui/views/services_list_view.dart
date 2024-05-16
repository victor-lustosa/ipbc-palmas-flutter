import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../service_module.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key, required this.entities});

  final List<ServicesEntity> entities;

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MainTopBarWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 17,
                      top: 30,
                    ),
                    child: BackButtonWidget(
                      action: () => nativePop(context),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 25, top: 10),
                  child: Text(
                    "Cultos",
                    style: AppFonts.title2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 25,
                    top: 8,
                    right: 20,
                  ),
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
                margin: const EdgeInsets.only(
                  top: 28,
                  left: 16,
                  right: 16,
                ),
                width: context.mediaQuery.size.width,
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
                        nativeNavigate(
                            ServiceModule.servicesCollectionRoute,
                            arguments: widget.entities[index],
                            context);
                      },
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.entities[index].image,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 16),
                              child: Text(
                                '${widget.entities[index].title} | ${widget.entities[index].hour}',
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
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

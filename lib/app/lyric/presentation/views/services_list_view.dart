import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/button/button_widget.dart';
import 'services_colletions_view.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView>
    with AutomaticKeepAliveClientMixin {
  final List<Map> servicesList = const [
    {
      'title': 'Sábado',
      'heading': 'sábado à noite (UMP)',
      'path': 'saturday-services/20',
      'hour': '19h30'
    },
    {
      'title': 'Domingo pela manhã',
      'heading': 'domingo pela manhã',
      'path': 'morning-sunday-services/20',
      'hour': '9h'
    },
    {
      'title': 'Domingo à noite',
      'heading': 'domingo à noite',
      'path': 'evening-sunday-services/20',
      'hour': '19h'
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MainTopBarWidget(),
              /*const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment(-0.97, 0),
                        child: BackButtonWidget(),
                      ),
                    ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17.0,
                      top: 33,
                    ),
                    child: Text(
                      "Cultos",
                      style: AppFonts.headHome,
                    ),
                  ), /*
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                            right: 0,
                          ),
                          child: SizedBox(
                            height: 30,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.lyricRoute,
                                );
                              },
                              icon: const Icon(
                                size: 32,
                                Icons.navigate_next_sharp,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ),
                        ),*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 8,
                ),
                child: Text(
                  "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                  style: AppFonts.subHeadHome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 28.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: Platform.isIOS ? 17 : 16,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: servicesList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ServiceCollectionsDTO service = ServiceCollectionsDTO(
                                                        path: servicesList[index]['path'],
                                                        heading: servicesList[index]['heading'],
                                                        image: AppImages.servicesImagesList[index],
                                                        hour: servicesList[index]['hour'],
                                                      );
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppImages.servicesImagesList[index],
                            ),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            top: Platform.isIOS ? 13 : 12.2,
                            bottom: Platform.isIOS ? 13 : 12.2,
                            left: 25,
                            right: 0,
                          ),
                          title: Text(
                            servicesList[index]['title'],
                            style: AppFonts.titleTile,
                          ),
                          trailing: IconButtonWidget(
                              size: Platform.isIOS ? 29 : 35,
                              color: AppColors.white,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iOSIcon: CupertinoIcons.chevron_forward,
                              androidIcon: Icons.navigate_next_sharp,
                              action: () =>
                                  Navigator.of(context).pushNamed(
                                  AppRoutes.servicesCollectionsRoute,
                                  arguments: service)
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                 AppRoutes.servicesCollectionsRoute,
                                arguments: service);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

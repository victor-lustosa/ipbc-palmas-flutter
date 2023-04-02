import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services_colletions_view.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
//import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';
import '../../../shared/components/utils/validation_util.dart';
import '../../domain/entities/service_entity.dart';
import '../blocs/service_bloc.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView>
    with AutomaticKeepAliveClientMixin {

  final String saturdayServicePath = 'saturday-services';
  final String morningSundayServicePath = 'morning-sunday-services';
  final String eveningSundayServicePath = 'evening-sunday-services';

  final List<Map> servicesList = const [
      {
      'title': 'Sábado',
      'heading': 'sábado à noite (UMP)',
      'path': 'saturday-services/20'
      },
     {
      'title': 'Domingo pela manhã',
      'heading': 'domingo pela manhã',
      'path': 'morning-sunday-services/20'
     },
     {
      'title': 'Domingo à noite',
       'heading': 'domingo pela manhã',
      'path': 'evening-sunday-services/20'
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
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return SizedBox(
                              height: Platform.isIOS ? 17 : 16,
                            );
                          },
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: servicesList.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
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
                                trailing: NextButtonWidget(
                                  size: Platform.isIOS ? 29 : 35,
                                  route: AppRoutes.lyricRoute,
                                  arguments: servicesList[index],
                                  color: AppColors.white,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.servicesCollectionsRoute,
                                      arguments: ServiceCollectionsDTO(
                                          path: servicesList[index]['path'],
                                          heading: servicesList[index]['heading'],
                                      )
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )));

}
}

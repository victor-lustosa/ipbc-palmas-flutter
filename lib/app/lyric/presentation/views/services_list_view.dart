import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/exception/view/no_connection_view.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';

import '../../../exception/view/generic_error_view.dart';
import '../../../shared/components/button/button_widget.dart';
import '../../../shared/components/loading/loading_widget.dart';
import '../../../shared/components/utils/validation_util.dart';
import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../infra/models/firestore-dtos/services_collection_dto.dart';
import '../blocs/services_collection_bloc.dart';
import 'services_colletion_view.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesListView extends StatefulWidget {
  const ServicesListView({super.key});

  @override
  State<ServicesListView> createState() => _ServicesListViewState();
}

class _ServicesListViewState extends State<ServicesListView>
    with AutomaticKeepAliveClientMixin {
  late final ServicesCollectionBloc servicesCollectionBloc;
  late final String database;
  late final DatabaseBloc databaseBloc;
  late List<ServicesCollectionDTO> servicesCollection;

  @override
  void initState() {
    servicesCollectionBloc = context.read<ServicesCollectionBloc>();
    databaseBloc = context.read<DatabaseBloc>();
    servicesCollectionBloc.add(CheckConnectivityEvent());
    //servicesCollectionBloc.add(GetCollectionInHiveEvent(path: ''));
    database = ValidationUtil.validationDatasource();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<ServicesCollectionBloc, ServicesCollectionState>(
            listener:(context, state) {

            },
            bloc: servicesCollectionBloc,
            builder: (context, state) {
              if (state is InitialState) {
                return const LoadingWidget();
              }
              if (state is LoadingCollectionState) {
                return const LoadingWidget();
              } if (state is NoConnectionAvailableState) {
                return const NoConnectionView(index: 0);
              } else if (state is SuccessfullyFetchedCollectionState) {
                servicesCollection = state.entities;
                return Column(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 17.0, top: 33),
                          child: Text(
                            "Cultos",
                            style: AppFonts.headHome,
                          ),
                        ), /*
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 18.0, top: 8),
                        child: Text(
                          "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                          style: AppFonts.subHeadHome,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 28.0,
                        left: 16,
                        right: 16,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 17);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: servicesCollection.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          /*ServiceCollectionsDTO service = ServiceCollectionsDTO(
                      path: servicesList[index]['path'],
                      heading: servicesList[index]['heading'],
                      image: AppImages.servicesImagesList[index],
                      hour: servicesList[index]['hour'],
                    );*/
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  servicesCollection[index].image,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 13),
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Container(
                                  margin: const EdgeInsets.only(left: 17),
                                  child: Text(
                                    '${servicesCollection[index].title} | ${servicesCollection[index].hour}',
                                    style: AppFonts.titleTile,
                                  ),
                                ),
                                trailing: Container(
                                  margin: const EdgeInsets.only(right: 3),
                                  child: IconButtonWidget(
                                    size: Platform.isIOS ? null : 33,
                                    color: AppColors.white,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    iOSIcon: CupertinoIcons.chevron_forward,
                                    androidIcon: Icons.navigate_next_sharp,
                                    action: () => Navigator.of(context).push(
                                      CustomTransitionPageRoute(
                                        child: ServicesCollectionView(
                                          servicesCollection:
                                              servicesCollection[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    CustomTransitionPageRoute(
                                      child: ServicesCollectionView(
                                        servicesCollection:
                                            servicesCollection[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              } else {
                return const GenericErrorView();
              }
            },
          ),
        ),
      ),
    );
  }
}

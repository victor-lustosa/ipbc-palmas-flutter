import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../layout/top-bar/main_top_bar_widget.dart';
import '../../exception/views/generic_error_view.dart';
import '../../exception/views/no_connection_view.dart';
import '../../service/blocs/services_list_bloc.dart';
import '../../shared/blocs/generics.dart';
import '../../shared/view-models/database_view_model.dart';
import '../home_module.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late final ServicesListBloc bloc;
  late List<ServicesEntity> entitiesList;
  int position = 0;

  @override
  void initState() {
    bloc = Modular.get<ServicesListBloc>();
    if (!Modular.get<DatabaseViewModel>().data.isServicesUpdated) {
      bloc.add(CheckConnectivityEvent());
    } else {
      bloc.add(GetInHiveEvent());
    }
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ServicesListBloc, GenericState<ServicesListState>>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadingState<ServicesListState>) {
              return const LoadingWidget();
            } else if (state is NoConnectionState<ServicesListState>) {
              return const NoConnectionView(index: 0);
            } else if (state
                is DataFetchedState<ServicesListState, ServicesEntity>) {
              entitiesList = state.entities;
              Modular.get<DatabaseViewModel>()
                  .checkUpdateData(context, 'services');
              return SingleChildScrollView(
                child: SizedBox(
                  width: context.mediaQuery.size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const MainTopBarWidget(),
                      title(text: "Eventos"),
                      subtitle(
                        right: 18,
                        text:
                            "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                      ),
                      InkWell(
                        onTap: (){
                          print("Vasco");
                        },
                        child: Column(
                          children: [
                            title(text: "Cultos"),
                            subtitle(
                              right: 17,
                              text:
                                  "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 24.5),
                        child: CarouselWidget(
                          fontStyle: AppFonts.defaultFont(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),
                          margin:
                              const EdgeInsets.only(left: 15.5, right: 15.5),
                          route: HomeModule.servicesCollectionRoute,
                          mainAxisAlignment: MainAxisAlignment.center,
                          width: context.mediaQuery.size.width,
                          height: 167,
                          services: entitiesList,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const GenericErrorView();
            }
          },
        ),
      ),
    );
  }

  Widget title({required String text}) => Container(
   // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
    margin: EdgeInsets.symmetric(horizontal: 17),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppFonts.title2,
            ),
            Container(
             // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              width: Platform.isIOS ? 30 : 35,
              child: IconButtonWidget(
                size: Platform.isIOS ? null : 33,
                color: AppColors.darkGreen,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iOSIcon: CupertinoIcons.chevron_forward,
                androidIcon: Icons.navigate_next_sharp,
                action: () {
                  Navigator.pushNamed(
                    context,
                    HomeModule.servicesListRoute,
                  );
                },

              ),
            ),
          ],
        ),
  );

  Widget subtitle({required double right, required String text}) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(left: 18, top: 8, right: right),
          child: Text(
            text,
            style: AppFonts.defaultFont(
              fontSize: 15,
              color: AppColors.grey9,
            ),
          ),
        ),
      );
}

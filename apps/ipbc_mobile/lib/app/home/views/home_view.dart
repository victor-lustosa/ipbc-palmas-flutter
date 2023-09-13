import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../layout/top-bar/main_top_bar_widget.dart';
import '../../exception/views/generic_error_view.dart';
import '../../exception/views/no_connection_view.dart';
import '../../service/blocs/services_list_bloc.dart';
import '../../shared/blocs/generics.dart';
import '../../shared/view-models/database_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  late final ServicesListBloc bloc;
  late List<ServicesEntity> entitiesList;

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
              return RefreshIndicator(
                color: AppColors.darkGreen,
                onRefresh: () async {
                  bloc.add(CheckConnectivityEvent());
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: context.mediaQuery.size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MainTopBarWidget(),
                        title("Eventos"),
                        subtitle(
                          const EdgeInsets.only(
                            left: 18,
                            top: 8,
                            right: 18,
                          ),
                          "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                        ),
                        title("Cultos"),
                        subtitle(
                          const EdgeInsets.only(
                            left: 18,
                            top: 8,
                            right: 17,
                          ),
                          "Acompanhe a liturgia e as letras das músicas cantadas nos cultos.",
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            bottom: 0,
                            top: 24.5,
                            left: 15.5,
                            right: 15.5,
                          ),
                          child: CarouselWidget(
                            fontStyle: AppFonts.defaultFont(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                            services: List.generate(
                                entitiesList.length,
                                (index) => {
                                      'label': entitiesList[index].title,
                                      'path': entitiesList[index].image,
                                    }),
                            width: context.mediaQuery.size.width,
                            height: 167,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      ],
                    ),
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

  Widget title(String text) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 17, top: 41),
            child: Text(
              text,
              style: AppFonts.title2,
            ),
          ),
        ],
      );

  Widget subtitle(EdgeInsetsGeometry padding, String text) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 18, top: 8, right: 18),
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

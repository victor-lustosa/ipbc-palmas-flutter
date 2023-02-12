import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';

import '../../domain/entities/service_entity.dart';
import '../../infra/models/dtos/service_param.dart';
import '../blocs/service_bloc.dart';
import '../../../shared/components/guideline/guideline_widget.dart';
import '../components/lyrics_list_widget.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key, required this.weekendDTO});

  final ServiceParam weekendDTO;

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {

  late final ServiceBloc bloc;
  late ServiceEntity service;

  @override
  void initState() {
    bloc = context.read<ServiceBloc>();
    bloc.add(GetServiceEvent(url: widget.weekendDTO.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServiceBloc, ServicesState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.darkGreen,
                ),
              ),
            );
          } else if (state is SuccessfullyFetchedServiceState) {
            service = state.entities;

            return SafeArea(
              child: SingleChildScrollView(
                child: RefreshIndicator(
                  color: AppColors.darkGreen,
                  onRefresh: () async {
                    bloc.add(
                      GetServiceEvent(url: widget.weekendDTO.url),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const MainTopBarWidget(),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 16.0,
                        ),
                        child: Align(
                          alignment: Alignment(-0.97, 0),
                          child: BackButtonWidget(
                            iOSIcon: CupertinoIcons.chevron_back,
                            androidIcon: Icons.arrow_back_rounded,
                            color: AppColors.darkGreen,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Platform.isIOS ? 16 : 16, bottom: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Align(
                                alignment: const Alignment(-1, 0),
                                child: Text(
                                  "Liturgia do Culto",
                                  style: AppFonts.headline,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.badgeGreen,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(34.7),
                                  ),
                                ),
                                height: 26,
                                child: Align(
                                  alignment: const Alignment(0, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: Text(
                                      "${widget.weekendDTO.title} ${service.createAt}",
                                      style: AppFonts.liturgyBadge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.955,
                        child: GuidelineWidget(liturgyList: service.liturgyList),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Platform.isIOS ? 24 : 20),
                        child: Align(
                          alignment:
                              Alignment(Platform.isIOS ? -0.4 : -0.15, 0),
                          child: SizedBox(
                            height: 25,
                            width: 350,
                            child: Align(
                              alignment: const Alignment(-1, 0),
                              child: Text(
                                "Músicas de ${widget.weekendDTO.heading}",
                                style: AppFonts.headline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Platform.isIOS ? 10.0 : 11,
                        ),
                        child: LyricsListWidget(
                          lyricsList: service.lyricsList,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("erro na tela [liturgy_view]"),
            );
          }
        },
      ),
    );
  }
}

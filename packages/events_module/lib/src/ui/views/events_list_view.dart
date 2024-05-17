import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

import '../../app_module.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({
    super.key,
  });

  @override
  State<EventsListView> createState() => EventsListViewState();
}

class EventsListViewState extends State<EventsListView> {
  int activePage = 0;
  final List<int> imagesList = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: context.mediaQuery.size.width,
          height: context.mediaQuery.size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 24,
                        left: 16,
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
                      "Eventos",
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
                      bottom: 12,
                    ),
                    child: Text(
                      "Proximos cultos, conferências, acompanhe todos os eventos da IPBC Palmas!",
                      style: AppFonts.defaultFont(
                        fontSize: 15,
                        height: 1.2,
                        color: AppColors.grey9,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.mediaQuery.size.height,
                  child: SlideCardsWidget(
                    margin: const EdgeInsets.only(
                      top: 16,
                      left: 16,
                      right: 16,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    width: context.mediaQuery.size.width,
                    scrollDirection: Axis.vertical,
                    services: const [],
                    route: '',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        action: () => pushNamed(
          EventModule.eventRoute + EventModule.createEventRoute,
        ),
        backgroundColor: AppColors.add,
        iconColor: AppColors.white,
        icon: Icons.add,
      ),
    );
  }
}

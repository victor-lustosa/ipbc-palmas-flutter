import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({
    Key? key,
  }) : super(key: key);

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
                const MainTopBarWidget(),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 24, left: 16),
                      child: BackButtonWidget(
                        action: () => Navigator.pop(context),
                      ),
                    ),
                  ],
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
    );
  }
}

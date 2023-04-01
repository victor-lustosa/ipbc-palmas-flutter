import 'package:flutter/material.dart';
import 'dart:io';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../domain/entities/service_entity.dart';

class ServicesCollectionsView extends StatefulWidget {
  const ServicesCollectionsView({Key? key, required this.servicesList, required this.weekday})
      : super(key: key);
  final List<ServiceEntity> servicesList;
  final String weekday;

  @override
  State<ServicesCollectionsView> createState() => _ServicesCollectionsViewState();
}

class _ServicesCollectionsViewState extends State<ServicesCollectionsView> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: const Color(0x66C8C8C8),
        highlightColor: const Color(0x66BCBCBC),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: Platform.isIOS ? 24 : 20),
            child: Align(
              alignment: Alignment(Platform.isIOS ? -0.4 : -0.15, 0),
              child: SizedBox(
                height: 25,
                width: 350,
                child: Align(
                  alignment: const Alignment(-1, 0),
                  child: Text(
                    "Cultos de ${widget.weekday}",
                    style: AppFonts.headline,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.93,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 4,
                );
              },
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.servicesList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Material(
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  color: AppColors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      left: 8,
                      right: 0,
                    ),
                    dense: true,
                    minVerticalPadding: 0,
                    minLeadingWidth: 0,
                    horizontalTitleGap: 4,
                    title: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4, left: 4
                      ),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        widget.servicesList[index].title,
                        style: AppFonts.lyricsTitleTile,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(
                           left: 4
                      ),
                      child: Text(
                        widget.servicesList[index].preacher,
                        style: AppFonts.subtitleTile,
                      ),
                    ),
                    trailing: NextButtonWidget(
                        size: Platform.isIOS ? 29 : 36,
                        route: AppRoutes.lyricRoute,
                        arguments: widget.servicesList[index],
                        color: AppColors.darkGreen),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        AppRoutes.lyricRoute,
                        arguments: widget.servicesList[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

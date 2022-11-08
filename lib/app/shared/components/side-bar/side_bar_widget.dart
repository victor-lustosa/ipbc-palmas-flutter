
import 'package:flutter/material.dart';
import '../../configs/app_colors.dart';
import '../../configs/app_fonts.dart';

class SideBarWidget extends StatelessWidget{

  final List<String> drawerNames;

  const SideBarWidget({required this.drawerNames, super.key});
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 170.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.72,
          child: Drawer(
            backgroundColor: AppColors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text('Victor', style: AppFonts.titleDrawer),
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: drawerNames.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(drawerNames[index],
                                    style: AppFonts.bodyDrawer),
                              ]),
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.lyricRoute,
                            //    arguments: lyricsFiltered[index]);
                      });
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
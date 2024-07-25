import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../app_module.dart';

class EventsDetailView extends StatefulWidget {
  const EventsDetailView({
    super.key,
  });

  @override
  State<EventsDetailView> createState() => EventsDetailViewState();
}

class EventsDetailViewState extends State<EventsDetailView> with LaunchUrlMixin {
  Future<void>? _locationLink;
  final Uri locationLink = Uri(
    scheme: 'https',
    host: 'maps.app.goo.gl',
    path: 'SGwA4JvUZ5SWNS287',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MainTopBarWidget(
                  margin: EdgeInsets.zero,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  width: context.mediaQuery.size.width,
                  height: 144,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        AppImages.littleGroupMd,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Text(
                      style: AppFonts.defaultFont(
                          color: AppColors.grey10,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      'Dia da Família'),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                              style: AppFonts.defaultFont(
                                  color: AppColors.darkGreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              'Ter, 10 de Outubro'),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 4,
                              right: 4,
                            ),
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.darkGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                              style: AppFonts.defaultFont(
                                  color: AppColors.darkGreen,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              '16h'),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            right: 26.33,
                          ),
                          height: 22,
                          child: InkWell(
                            child: Image.asset(AppIcons.iosShare),
                          )),
                    ]),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 4,
                    top: 8,
                  ),
                  child: Text(
                      style: AppFonts.defaultFont(
                          color: AppColors.grey10,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                      'Dia da família IPBC Palmas'),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 1,
                      ),
                      child: Image.asset(height: 14, AppIcons.locationOn),
                    ),
                    Text(
                        style: AppFonts.defaultFont(
                            color: AppColors.grey8,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        'Parque Cesamar'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 16,
                    top: 16,
                  ),
                  child: Text(
                      style: AppFonts.defaultFont(
                          color: AppColors.grey8,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                      'Lorem ipsum dolor sit amet consectetur. '
                      'Egestas dictum in molestie tempor malesuada '
                      'donec amet neque. Massa non ac neque habitant '
                      'pellentesque lorem ullamcorper enim quis'),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                    child: Container(
                      width: context.mediaQuery.size.width,
                      height: 140,
                      child: GoogleMap(
                        scrollGesturesEnabled: false,
                        myLocationButtonEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target:
                              LatLng(-10.195851391811726, -48.31897737627334),
                          zoom: 15,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId('0'),
                            position:
                                LatLng(-10.195851391811726, -48.31897737627334),
                            onTap: () => {
                            _locationLink = launchInBrowser(locationLink)
                            },
                          )
                        },
                      ),
                    )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 95.82,
                    top: 14,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: ()=> print('VASCO'),
                      child: SizedBox(
                        width: 121,
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 16,
                              ),
                              child: Text(
                                  style: AppFonts.defaultFont(
                                      color: AppColors.darkGreen,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                  'Inscrições'),
                            ),
                            IconButtonWidget(
                              size: Platform.isIOS ? 24 : 28,
                              color: AppColors.darkGreen,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iOSIcon: CupertinoIcons.chevron_forward,
                              androidIcon: Icons.navigate_next_sharp,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
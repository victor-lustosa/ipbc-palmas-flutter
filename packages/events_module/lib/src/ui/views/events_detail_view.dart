
import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

//import 'package:flutter/services.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import '../../app_module.dart';

class EventsDetailView extends StatefulWidget {
  final EventEntity eventEntity;

  const EventsDetailView({super.key, required this.eventEntity});

  @override
  State<EventsDetailView> createState() => EventsDetailViewState();
}

class EventsDetailViewState extends State<EventsDetailView>
    with LaunchUrlMixin, DateMixin {
  Future<void>? locationLink;
  final Uri _locationLink = Uri(
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
                MainTopBarWidget(
                  margin: const EdgeInsets.only(top: 22, bottom: 15),
                  items: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonWidget(action: () => nativePop(context)),
                      AuthCircleAvatarWidget(),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 24, bottom: 16),
                  child: CachedNetworkImage(
                    imageUrl: widget.eventEntity.image,
                    height: 144,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColors.grey4),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    color: const Color.fromRGBO(0, 66, 46, 0.40),
                    colorBlendMode: BlendMode.color,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
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
                      fontWeight: FontWeight.w500,
                    ),
                    widget.eventEntity.title,
                  ),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          style: AppFonts.defaultFont(
                            color: AppColors.darkGreen,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          getFormattedDateTimeFull(
                            widget.eventEntity.startDateTime,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 4, right: 4),
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
                            fontWeight: FontWeight.w500,
                          ),
                          formatHourToString(
                            date: widget.eventEntity.startDateTime,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 4, top: 8, right: 8),
                        child: Text(
                          style: AppFonts.defaultFont(
                            color: AppColors.grey10,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          widget.eventEntity.subtitle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                      child: InkWell(child: Image.asset(AppIcons.iosShare)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 1),
                      child: Image.asset(height: 14, AppIcons.locationOn),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 4),
                        child: Text(
                          style: AppFonts.defaultFont(
                            color: AppColors.grey8,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                          widget.eventEntity.localName,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16, top: 16),
                  child: Text(
                    style: AppFonts.defaultFont(
                      color: AppColors.grey8,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    widget.eventEntity.description,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  child: SizedBox(
                    width: context.mediaQuery.size.width,
                    height: 140,
                    child: GoogleMap(
                      scrollGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(-10.195851391811726, -48.31897737627334),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('0'),
                          position: LatLng(
                            -10.195851391811726,
                            -48.31897737627334,
                          ),
                          onTap: () => {
                            locationLink = launchInBrowser(_locationLink),
                          },
                        ),
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),
                ButtonWidget(
                  action: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  fixedSize: Size(context.sizeOf.width, 48),
                  backgroundColor: AppColors.darkGreen,
                  shadowColor: AppColors.grey0,
                  foregroundColor: AppColors.white,
                  child: const Text("Inscrições"),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 40),
                  child: ButtonWidget(
                    action: () {},
                    adaptiveButtonType: AdaptiveButtonType.outlined,
                    sideColor: AppColors.darkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: Size(context.sizeOf.width, 48),
                    backgroundColor: AppColors.white,
                    shadowColor: AppColors.grey0,
                    foregroundColor: AppColors.darkGreen,
                    child: const Text("Contato"),
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

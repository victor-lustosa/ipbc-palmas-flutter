import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

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
  Future<void>? signUpLink;
  Future<void>? contactLink;
  ValueNotifier<bool> isChanged = ValueNotifier(false);
  late final CreateEventStore _createEventStore;
  late EventEntity event;

  @override
  void initState() {
    super.initState();

    _createEventStore = Modular.get<CreateEventStore>();
    event = widget.eventEntity;
  }

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(
      event.latitude ?? 0,
      event.longitude ?? 0,
    );
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isEqualDate = (isSameDate(
              event.startDateTime,
              event.endDateTime,
            ));
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BackAuthTopBarWidget(
                            margin: const EdgeInsets.only(top: 22),
                            action: () {
                              if(_createEventStore.fromCalled == 'home'){
                                if(_createEventStore.updateHomeViewCallback != null && isChanged.value){
                                  isChanged.value = false;
                                  _createEventStore.updateHomeViewCallback!();
                                }
                              }
                              if(_createEventStore.fromCalled == 'eventList'){
                                if(_createEventStore.updateEventListViewCallback != null && isChanged.value){
                                  isChanged.value = false;
                                  _createEventStore.updateEventListViewCallback!();
                                }
                              }
                              nativePop(context);
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 16),
                            child: CachedNetworkImage(
                              imageUrl: event.image,
                              height: 144,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container(color: AppColors.grey4),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              color: const Color.fromRGBO(0, 66, 46, 0.40),
                              colorBlendMode: BlendMode.color,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              event.title,
                            ),
                          ),

                          ((isEqualDate) ||
                                  (!isEqualDate && event.isAllDay))
                              ? Row(
                                  children: [
                                    Text(
                                      style: AppFonts.defaultFont(
                                        color: AppColors.darkGreen,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),

                                      isEqualDate
                                          ? getFormattedDateTimeFull(
                                              event.startDateTime,
                                              isNotYear: true,
                                            )
                                          : "${getFormattedDateTimeFull(event.startDateTime, isShortDate: true)} a ${getFormattedDateTimeFull(event.endDateTime, isShortDate: true)}",
                                    ),

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
                                        fontWeight: FontWeight.w500,
                                      ),
                                      event.isAllDay
                                          ? 'O dia todo'
                                          : "${formatHourToString(date: event.startDateTime)} às ${formatHourToString(date: event.endDateTime)}",
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(
                                      width: context.sizeOf.width - 32,
                                      child: Text(
                                        style: AppFonts.defaultFont(
                                          color: AppColors.darkGreen,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        "${getFormattedDateTimeFull(event.startDateTime, isDateAndTime: true)} a ${getFormattedDateTimeFull(event.endDateTime, isDateAndTime: true)}",
                                      ),
                                    ),
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 4,
                                    top: 8,
                                    right: 8,
                                  ),
                                  child: Text(
                                    style: AppFonts.defaultFont(
                                      color: AppColors.grey10,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    event.subtitle,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                                child: InkWell(
                                  child: Image.asset(AppIcons.iosShare),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 1),
                                child: Image.asset(
                                  height: 14,
                                  AppIcons.locationOn,
                                ),
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
                                    event.localName ?? '',
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
                              event.description,
                            ),
                          ),
                          Visibility(
                            visible:
                                event.latitude != null &&
                                event.longitude != null,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(18),
                              ),
                              child: SizedBox(
                                width: context.mediaQuery.size.width,
                                height: 140,
                                child: GoogleMap(
                                  scrollGesturesEnabled: false,
                                  myLocationButtonEnabled: false,
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: position,
                                    zoom: 15,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId: MarkerId('0'),
                                      position: position,
                                      onTap: () => {
                                        locationLink = launchInBrowser(
                                          Uri.parse(
                                            "https://www.google.com/maps/search/?api=1&query=${event.latitude!},${event.longitude!}",
                                          ),
                                        ),
                                      },
                                    ),
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Visibility(
                            visible:
                                event.signUpLink != null &&
                                event.signUpLink!.isNotEmpty,
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: ButtonWidget(
                                action: () {
                                  signUpLink = launchInBrowser(
                                    Uri.parse(
                                      event.signUpLink ?? '',
                                    ),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                fixedSize: Size(context.sizeOf.width, 48),
                                backgroundColor: AppColors.darkGreen,
                                shadowColor: AppColors.grey0,
                                foregroundColor: AppColors.white,
                                child: const Text("Inscrições"),
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                event.contactLink != null &&
                                event.contactLink!.isNotEmpty,
                            child: Container(
                              margin: const EdgeInsets.only(
                                top: 16,
                                bottom: 40,
                              ),
                              child: ButtonWidget(
                                action: () {
                                  contactLink = launchInBrowser(
                                    Uri.parse(
                                      event.contactLink ?? '',
                                    ),
                                  );
                                },
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingButtonWidget(
          iconColor: AppColors.white,
          backgroundColor: AppColors.warning,
          pngIcon: AppIcons.editIcon,
          size: 37,
          action: () async {
            _createEventStore.isEditing = true;
            _createEventStore.eventEntity = event;
            _createEventStore
                .updateCallbackParam = () {
                    setState(() {
                      event = _createEventStore.eventEntity;
                       isChanged.value = true;

                    });
                      pop();

            };

            _createEventStore.deleteCallback = () {
              if (_createEventStore.fromCalled == 'home') {
                if (_createEventStore.updateHomeViewCallback != null) {
                  _createEventStore.updateHomeViewCallback!();
                }
              } else if (_createEventStore.fromCalled == 'eventsList') {
                if (_createEventStore.updateEventListViewCallback != null) {
                  _createEventStore.updateEventListViewCallback!();
                }
              }
              int count = 0;
              nativePopUntil((_) => count++ >= 2, context);

            };
            await pushNamed(
              AppRoutes.eventRoute +
                  AppRoutes.createEventRoute,
            );
          },
        ),
      ),
    );
  }
}

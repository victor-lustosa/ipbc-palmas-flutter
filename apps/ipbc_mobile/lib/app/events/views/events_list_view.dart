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
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: imagesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Container(
                              height: 144,
                              margin: EdgeInsets.only(
                                  top: index == 0 ? 16 : 0,
                                  left: 16,
                                  right: 16),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                    offset: Offset(5, 5),
                                    color: AppColors.grey2,
                                  )
                                ],
                                color: AppColors.grey4,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Color.fromRGBO(0, 66, 46, 0.40),
                                    BlendMode.color,
                                  ),
                                  image: AssetImage(AppImages.familyDayImage),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Dia da Família',
                                  style: AppFonts.defaultFont(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 101,
                              margin: const EdgeInsets.only(
                                  bottom: 16, left: 16, right: 16),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 18,
                                    spreadRadius: 1,
                                    offset: Offset(8, 8),
                                    color: AppColors.grey2,
                                  )
                                ],
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(left: 12),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Ter, 10 de Outubro',
                                            style: AppFonts.defaultFont(
                                              color: AppColors.darkGreen,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              left: 5,
                                              top: 1,
                                              right: 5,
                                            ),
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              color: AppColors.darkGreen,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Text(
                                            '16h',
                                            style: AppFonts.defaultFont(
                                              color: AppColors.darkGreen,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Dia da família IPBC Palmas',
                                            style: AppFonts.defaultFont(
                                              color: AppColors.grey12,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 12),
                                            width: 20,
                                            child: const Image(
                                              fit: BoxFit.fitWidth,
                                              image: AssetImage(
                                                AppIcons.iosShare,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(right: 4),
                                            width: 11,
                                            child: const Image(
                                              fit: BoxFit.fitWidth,
                                              image: AssetImage(
                                                AppIcons.locationOn,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Parque Casamar',
                                            style: AppFonts.defaultFont(
                                              color: AppColors.grey8,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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

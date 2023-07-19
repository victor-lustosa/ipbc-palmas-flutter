import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_web/src/shared/components/tab_buttons_widget.dart';

class TopBarWidget extends StatefulWidget {
  const TopBarWidget({super.key});

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 24,
            left: 110,
            right: 134,
            bottom: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Image(
                width: 100,
                image: AssetImage(
                  AppImages.logo,
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabButtonsWidget(label: 'Sobre', action: () {}),
                    TabButtonsWidget(label: 'Localização', action: () {}),
                    TabButtonsWidget(label: 'App', action: () {}),
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(AppColors.white),
                        shadowColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return states.contains(MaterialState.hovered)
                                  ? AppColors.darkGreen
                                  : AppColors.grey6; // Defer to the widget's default.
                            }),
                        overlayColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.darkGreen),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.darkGreen),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                              horizontal: 36,
                              vertical: 21.5,
                            )),
                        textStyle: MaterialStateProperty.all<TextStyle?>(
                            AppFonts.defaultFont(fontSize: 18)),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Entrar em contato'),
                          Container(
                            margin: const EdgeInsets.only(left: 16),
                            child: Image.asset(
                              AppIcons.callIcon,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(color: AppColors.grey5),
          height: 0.4,
        )
      ],
    );
  }
}

/*class TopBarWidget extends PreferredSize {

  static final List<String> contentViews = ['Sobre', 'Localização', 'Apps'];

  TopBarWidget({super.key}) : super(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Flexible(flex: 2, child: SizedBox(width: 100)),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          tabButtons(contentViews[0]),
                          tabButtons(contentViews[1]),
                          tabButtons(contentViews[2]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  static Widget tabButtons(String label) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: MaterialButton(
          hoverColor: Colors.white,
          child: Text(
            label,
            style: AppFonts.defaultFont(fontSize: 18, color: AppColors.grey6),
          ),
          onPressed: () {},
        ),
      );
}
*/
/*class TopBarWidget extends PreferredSize {
  final List<String> contentViews;
  final TabController tabController;
  TopBarWidget(
      {super.key, required this.tabController, required this.contentViews})
      : super(
          preferredSize: const Size.fromHeight(100),
          child: SafeArea(
            child: Column(
              children: [
                Container(height: 20, width: 20,
                    decoration: const BoxDecoration(color: AppColors.darkGreen)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Flexible(flex: 2, child: SizedBox(width: 100)),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        child: TabBar(
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          labelColor: AppColors.darkGreen,
                          isScrollable: true,
                          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                          unselectedLabelColor: AppColors.grey6,
                          controller: tabController,
                          indicatorColor: Colors.transparent,
                          labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          tabs: <Widget>[
                            Container(margin: const EdgeInsets.symmetric(horizontal: 10),child: Tab(text: contentViews[0])),
                            Container(margin: const EdgeInsets.symmetric(horizontal: 10),child: Tab(text: contentViews[1])),
                            Container(margin: const EdgeInsets.symmetric(horizontal: 10),child: Tab(text: contentViews[2])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(color: AppColors.darkGreen),
                )
              ],
            ),
          ),
        );
}
*/

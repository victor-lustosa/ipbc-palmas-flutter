import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> with LaunchUrlMixin {
  Future<void>? _locationLink;

  final Uri locationLink = Uri(
    scheme: 'https',
    host: 'goo.gl',
    path: 'maps/p25aM3t4Azo23URo7',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 100),
      decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 40,
                  offset: Offset(4, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Image(
              width: 573.26,
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages.churchLocation,
              ),
            ),
          ),
          Container(
            height: 273,
            margin: const EdgeInsets.only(left: 80, right: 69.74),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 23),
                  child: Text(
                    'Localização',
                    style: AppFonts.defaultFont(
                      fontSize: 46,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff242426),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    'A igreja fica localizada na quadra central em Palmas/TO.',
                    style: AppFonts.defaultFont(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff545456),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Image.asset(
                        AppIcons.churchLocationIcon,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    SizedBox(
                      width: 437,
                      child: Text(
                        'Quadra Arse 23, Av.Ns 06, Ai 09 - Plano Diretor Sul, Palmas - TO',
                        style: AppFonts.defaultFont(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff545456),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 215,
                  margin: const EdgeInsets.only(top: 40),
                  height: 49,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.hovered)
                            ? const BorderSide(
                                color: AppColors.darkGreen, width: 1)
                            : const BorderSide(
                                color: Color(0xCC005B40), width: 1);
                      }),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.hovered)
                            ? AppColors.darkGreen
                            : const Color(0xCC005B40);
                      }),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xfff3f3f3)),
                      overlayColor: MaterialStateProperty.all<Color>(
                          const Color(0xfff3f3f3)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle?>(
                          AppFonts.defaultFont(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                    ),
                    onPressed: () {
                      _locationLink = launchInBrowser(locationLink);
                    },
                    child: Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 6),
                            child: const Text('Ver Localização')),
                        Container(
                          margin: const EdgeInsets.only(left: 16),
                          child: Image.asset(
                            AppIcons.darkGreenArrowIcon,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

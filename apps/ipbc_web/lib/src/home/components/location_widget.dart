import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 587,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 100),
      decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 573.26,
            height: 387.18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/page-1/images/screenshot-2023-07-09-at-220-1-YAB.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 160,
            margin: const EdgeInsets.only(left: 80,right: 69.74),
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
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/page-1/images/locationon-FKu.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      // ploremipsumdolorsitametconsect (1:205)
                      'Endereço',
                      style: AppFonts.defaultFont(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff545456),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 120,
            top: 100,
            right: 189.74,
            bottom: 100,
          ),
          height: 587.18,
          decoration: const BoxDecoration(
            color: Color(0xfff3f3f3),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 80),
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
                margin: const EdgeInsets.symmetric(vertical: 115.09),
                width: 477,
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
                    Container(
                      margin: const EdgeInsets.only(right: 356),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

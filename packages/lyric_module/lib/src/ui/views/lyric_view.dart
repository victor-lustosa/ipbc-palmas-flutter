import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LyricView extends StatefulWidget {
  const LyricView({super.key, required this.entity});

  final LyricEntity entity;

  @override
  State<LyricView> createState() => _LyricViewState();
}

class _LyricViewState extends State<LyricView> with LaunchUrlMixin {
  final Uri toLaunch = Uri(
    scheme: 'https',
    host: 'api.vagalume.com.br',
    path: 'terms/',
  );

  Future<void>? _launched;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 35,
                      left: 17,
                      right: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 13),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: AlbumCoverWidget(
                                    height: 72,
                                    width: 72,
                                    albumCover: widget.entity.albumCover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: context.sizeOf.width *
                                  ResponsivityUtil.resolutionDeviceProportion(
                                      context.sizeOf.width, 0.573, 0.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      widget.entity.title,
                                      style: AppFonts.defaultFont(
                                        color: AppColors.grey9,
                                        fontWeight: FontWeight.w500,
                                        fontSize: context.sizeOf.width >
                                                ResponsivityUtil
                                                    .smallDeviceWidth
                                            ? 20
                                            : 17,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    widget.entity.group,
                                    style: AppFonts.defaultFont(
                                      color: AppColors.grey9,
                                      fontSize: context.sizeOf.width >
                                              ResponsivityUtil.smallDeviceWidth
                                          ? 15
                                          : 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButtonWidget(
                          size: 33,
                          color: AppColors.darkGreen,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iOSIcon: CupertinoIcons.clear_thick,
                          androidIcon: Icons.close_rounded,
                          action: () => pop(context),
                        ),
                      ],
                    ),
                  ),
                   Container(
                     //top: 15, sem a validacao de se é refrao ou nao
                     margin: const EdgeInsets.only(top: 28),
                     child: VersesListWidget(
                       isEdit: false,
                       entity: widget.entity.verses,
                     ),
                   ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 60,
                      left: 16,
                      right: 16,
                      bottom: 30,
                    ),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "Esse sistema não possui fins lucrativos sobre a obra representada a cima. Todos os direitos reservados aos autores da letra. ",
                              style: context.sizeOf.width >
                                      ResponsivityUtil.smallDeviceWidth
                                  ? AppFonts.copyright(fontSize: 13)
                                  : AppFonts.copyright(fontSize: 12),
                            ),
                            TextSpan(
                              style: AppFonts.defaultFont(
                                color: AppColors.darkGreen,
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                              ),
                              text: "Saiba mais.",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => setState(
                                      () {
                                        _launched = launchInBrowser(toLaunch);
                                        if (kDebugMode) {
                                          print(_launched);
                                        }
                                      },
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 77,
                    width: 145,
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: const BoxDecoration(
                      color: AppColors.vagalumeBackground,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Image(
                            width: 90,
                            height: 35,
                            fit: BoxFit.contain,
                            image: AssetImage(
                              AppImages.vagalumeImage,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 3),
                          child: Text(
                            'Lyrics by Vagalume',
                            style: AppFonts.defaultFont(
                              color: AppColors.darkGreen,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../components/album_cover_widget.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../../configs/app_configs.dart';
import '../../../shared/mixins/launch_url_mixin.dart';
import '../../../shared/components/button/button_widget.dart';
import '../../../shared/components/utils/responsivity_util.dart';

class LyricView extends StatefulWidget {
  const LyricView({super.key, required this.lyricEntity});

  final LyricEntity lyricEntity;
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
                                      height: 75,
                                      width: 75,
                                      albumCover: widget.lyricEntity.albumCover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  ResponsivityUtil.resolutionDeviceProportion(MediaQuery.of(context).size.width, 0.56, 0.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      widget.lyricEntity.title,
                                      style: MediaQuery.of(context).size.width >
                                              ResponsivityUtil.widthDevice
                                          ? AppFonts.defaultFont(
                                              color: AppColors.grey9,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 21,
                                            )
                                          : AppFonts.defaultFont(
                                              color: AppColors.grey9,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                            ),
                                    ),
                                  ),
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    widget.lyricEntity.group,
                                    style: MediaQuery.of(context).size.width >
                                        ResponsivityUtil.widthDevice
                                        ? AppFonts.defaultFont(
                                            fontSize: 15,
                                            color: AppColors.grey10,
                                         )
                                        : AppFonts.defaultFont(
                                            fontSize: 14,
                                            color: AppColors.grey10,
                                         ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButtonWidget(
                          size: Platform.isIOS ? 30 : 33,
                          color: AppColors.darkGreen,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iOSIcon: CupertinoIcons.clear_thick,
                          androidIcon: Icons.close_rounded,
                          action: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //top: 15, sem a validacao de se é refrao ou nao
                    margin: const EdgeInsets.only(top: 30),
                    child: ListView.separated(
                      separatorBuilder: (__, _) {
                        return const SizedBox();
                      },
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.lyricEntity.verses.length,
                      itemBuilder: (_, index) {
                        return Container(
                          decoration:
                              const BoxDecoration(color: AppColors.white),
                          margin: widget.lyricEntity.verses[index].isChorus
                              ? const EdgeInsets.only(left: 18, right: 16)
                              : const EdgeInsets.only(left: 8),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              alignment: widget.lyricEntity.verses[index].isChorus
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: widget.lyricEntity.verses[index].isChorus
                                      ? const Color.fromRGBO(0, 168, 118, 0.1)
                                      : AppColors.white,
                              ),
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: 14,
                                  bottom: 14,
                                  right: widget.lyricEntity.verses[index].isChorus
                                          ? 5
                                          : 15,
                                ),
                                child: ListView.separated(
                                  separatorBuilder: (__, _) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: widget.lyricEntity.verses[index].versesList.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: ((__, position) {
                                    return Container(
                                      margin: const EdgeInsets.only(
                                        left: 18,
                                        top: 2,
                                        bottom: 2,
                                      ),
                                      child: Text(
                                        widget.lyricEntity.verses[index].versesList[position],
                                        style: MediaQuery.of(context).size.width >
                                                    ResponsivityUtil.widthDevice
                                                ? AppFonts.defaultFont(
                                                    color: AppColors.grey10,
                                                    fontSize: 17,
                                                  )
                                                : AppFonts.defaultFont(
                                                    color: AppColors.grey10,
                                                    fontSize: 15,
                                                  ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 60,
                      left: 10,
                      bottom: 30,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "  Esse sistema não possui fins lucrativos sobre a obra representada a cima. Todos os direitos reservados aos autores da letra. ",
                                style: MediaQuery.of(context).size.width >
                                        ResponsivityUtil.widthDevice
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
                                          _launched = launchInWebViewOrVC(toLaunch);
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
                  ),
                  Container(
                    height: 77,
                    width: 145,
                    decoration: const BoxDecoration(
                      color: AppColors.grey11,
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
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/shared/components/utils/responsivity_util.dart';

import '../../../shared/components/button/button_widget.dart';
import '../../../shared/mixins/launch_url_mixin.dart';
import '../../../shared/configs/app_configs.dart';
import '../../domain/entities/lyric_entity.dart';

class LyricView extends StatefulWidget {
  const LyricView({super.key, required this.lyricEntity});

  final LyricEntity lyricEntity;
  @override
  State<LyricView> createState() => _LyricViewState();
}

class _LyricViewState extends State<LyricView> with LaunchUrlMixin {
  final Uri toLaunch = Uri(scheme: 'https', host: 'api.vagalume.com.br', path: 'terms/');

  Future<void>? _launched;


  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children:[
        Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 35.0,left: 17,right: 24),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Align(
                        alignment: const Alignment(-1.0, 0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          child: Image.asset(
                            height: 75,
                            width: 75,
                            widget.lyricEntity.albumCover,
                            //color: Color(0xFF92E9D9,),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2.0),
                        child: Align(
                          alignment: const Alignment(0.25, 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width *
                                ResponsivityUtil.resolutionDeviceProportion(MediaQuery.of(context).size.width, 0.55, 0.52),
                            child: Align(
                              alignment: const Alignment(-1, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      widget.lyricEntity.title,
                                      style: MediaQuery.of(context).size.width >
                                          ResponsivityUtil.widthDevice
                                          ? AppFonts.h2
                                          : AppFonts.h2Reduced,
                                    ),
                                  ),
                                  Text(
                                    widget.lyricEntity.group,
                                    style: AppFonts.subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(1, 0),
                        child: SizedBox(
                            child:  IconButtonWidget(
                              size: Platform.isIOS ? 30 : 33,
                              color: AppColors.darkGreen,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iOSIcon: CupertinoIcons.clear_thick,
                              androidIcon: Icons.close_rounded,
                              action: () => Navigator.pop(
                                context,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      //top: 15.0, sem a validacao de se é refrao ou nao
                       top: 30),
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
                        margin: widget.lyricEntity.verses[index].isChorus == true
                            ? const EdgeInsets.only(
                                left: 18.0,
                                right: 16,
                              )
                            : const EdgeInsets.only(
                                left: 8.0,
                              ),
                        child: Container(
                          alignment:
                              widget.lyricEntity.verses[index].isChorus == true
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          decoration:
                              widget.lyricEntity.verses[index].isChorus == true
                                  ? const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Color.fromRGBO(0, 168, 118, 0.1),
                                    )
                                  : const BoxDecoration(
                                      color: AppColors.white
                                    ),
                          child: Container(
                            // ignore: todo
                            //TODO: Averiguar se é possivel um refrao ser a primeira caixinha
                            margin: EdgeInsets.only(
                                top: 14,
                                bottom: 14,
                                right:
                                    widget.lyricEntity.verses[index]
                                        .isChorus == false
                                        ? 15
                                        : 5),
                            child: ListView.separated(
                              separatorBuilder: (__, _) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              itemCount: widget
                                  .lyricEntity.verses[index].versesList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((__, position) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 18.0, top: 2, bottom: 2),
                                  child: Text(
                                    widget.lyricEntity.verses[index]
                                        .versesList[position],
                                    style: MediaQuery.of(context).size.width >
                                        ResponsivityUtil.widthDevice
                                        ? AppFonts.lyricTile
                                        : AppFonts.lyricTileReduced,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60.0, left: 10, bottom: 30),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "  Esse sistema não possui fins lucrativos sobre a obra representada a cima. Todos os direitos reservados aos autores da letra. ",
                              style:
                                  MediaQuery.of(context).size.width > ResponsivityUtil.widthDevice
                                      ? AppFonts.copyright
                                      : AppFonts.copyrightReduced,
                            ),
                            TextSpan(
                              style: AppFonts.learnMore,
                              text: "Saiba mais.",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => setState(
                                      () {
                                        _launched = launchInWebViewOrVC(toLaunch);
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
                    color: AppColors.logoGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
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
                        margin: const EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          'Lyrics by Vagalume',
                          style: AppFonts.logoVagalume,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                )
              ],
            ),
          ),
        ),
      ),]
    );
  }
}

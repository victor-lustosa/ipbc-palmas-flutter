import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/mixins/launch_url_mixin.dart';
import '../../../shared/configs/app_configs.dart';
import '../../domain/entities/lyric_entity.dart';
import 'dart:io';

class LyricView extends StatefulWidget {
  const LyricView({super.key, required this.lyricEntity});

  final LyricEntity lyricEntity;

  @override
  State<LyricView> createState() => _LyricViewState();
}

class _LyricViewState extends State<LyricView> with LaunchUrlMixin {
  final Uri toLaunch =
      Uri(scheme: 'https', host: 'api.vagalume.com.br', path: 'terms/');
  // ignore: unused_field
  Future<void>? _launched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Align(
                      alignment: const Alignment(-0.86, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(11),
                          ),
                          child: Container(
                            color: AppColors.lightGrey,
                            width: 75,
                            height: 75,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: Align(
                        alignment: Alignment(Platform.isIOS ? 0.01 : 0.1, 0),
                        child: SizedBox(
                          height: 55,
                          width: 200,
                          /*decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),*/
                          child: Align(
                            alignment: const Alignment(-1, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Text(
                                    widget.lyricEntity.title,
                                    style: AppFonts.h2,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 0, top: 21),
                      child: Align(
                        alignment: const Alignment(0.9, 0),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: BackButtonWidget(
                            iOSIcon: CupertinoIcons.clear_thick,
                            androidIcon: Icons.close_rounded,
                            color: AppColors.darkGreen,
                            size: Platform.isIOS ? 30 : 33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    //top: 15.0, sem a validacao de se é refrao ou nao
                    top: 30),
                child: ListView.separated(
                  separatorBuilder: (__, _) {
                    return const SizedBox(
                      height: 0,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.lyricEntity.verses.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: widget.lyricEntity.verses[index].isChorus == true
                          ? const EdgeInsets.only(
                              left: 18.0,
                              right: 18,
                            )
                          : const EdgeInsets.only(
                              left: 8.0,
                              right: 0.0,
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
                                    //color: Color.fromARGB(143, 210, 238, 229),
                                    color: Color.fromARGB(143, 196, 239, 225),
                                  )
                                : const BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                        child: Padding(
                          // ignore: todo
                          //TODO: Averiguar se é possivel um refrao ser a primeira caixinha
                          padding: EdgeInsets.only(
                              top: widget.lyricEntity.verses[index].isChorus ==
                                      true
                                  ? 20
                                  : 0,
                              bottom: 20,
                              right: 5),
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
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, top: 2, bottom: 2),
                                child: Text(
                                  widget.lyricEntity.verses[index]
                                      .versesList[position],
                                  style: AppFonts.lyricTile,
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
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 10, bottom: 30),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "  Esse sistema não possui fins lucrativos sobre a obra representada a cima. Todos os direitos reservados aos autores da letra. ",
                            style: AppFonts.copyright,
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Image(
                        width: 90,
                        height: 35,
                        fit: BoxFit.contain,
                        image: AssetImage(
                          AppImages.vagalumeImage,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/verse_dto.dart';


import '../../shared/components/util.dart';
import '../domain/entities/lyric_entity.dart';


class LyricView extends StatefulWidget {
  const LyricView({ required this.lyricEntity});
  final LyricEntity lyricEntity;
  @override
  State<LyricView> createState() => _LyricViewState();
}

class _LyricViewState extends State<LyricView> {
late List<VerseDTO> listVerseDTO ;
@override
  void initState() {
 listVerseDTO =  Util.generateVersesList(widget.lyricEntity);
 print(listVerseDTO);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child:
        SizedBox(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.lyricEntity.verses.length,
              itemBuilder: (context, index) {
                var idPosition = widget.lyricEntity.verses[index].id;
                return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(

                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.8,

                                child: Text(widget.lyricEntity.verses[idPosition].textView))
                          ]
                      ),
                    )
                );
              }
          ),
        )));
  }
}

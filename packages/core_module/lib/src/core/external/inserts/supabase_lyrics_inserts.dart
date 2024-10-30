import 'package:flutter/material.dart';

import '../../../../core_module.dart';
// ignore_for_file: avoid_print

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseDatasource.init();
  SupabaseDatasource supa =
      SupabaseDatasource(supabaseClient: Supabase.instance.client);
  try {
    List<LyricModel> lyricsInserted =
        await SupaServicesUtil.convertUnknownLyrics(
            'assets/data/unknown-lyrics/lyrics_mock.json');
    // inserindo lista de todas as letras
    for (LyricEntity lyric in lyricsInserted) {
      supa.add('lyrics', SupaLyricAdapter.toMap(lyric));
    }
    print('lyrics list have been successfully added');
  } catch (e) {
    print('$e');
  }
}

/*List<Map<String,dynamic>> servicesList = await SupaServicesUtil.servicesListFilled();
    for (Map serviceMetadata in servicesList) {
      supa.add('services', serviceMetadata);
    }
  print('Services list have been successfully added');
  */
import 'dart:developer';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import '../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';

Future<DateTime> dateNow() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => DateTime.now(),
  );
}

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(
    DatabaseConfigsHiveDTOAdapter(),
  );
  await Hive.openBox<DatabaseConfigsHiveDTO>('database_configs');
  //await Hive.openBox<DatabaseConfigsHiveDTO>('database_configs');
  Box<DatabaseConfigsHiveDTO> box = Hive.box<DatabaseConfigsHiveDTO>('database_configs');
  box.put(0, DatabaseConfigsHiveDTO(updateAt: DateTime.now()));
  DatabaseConfigsHiveDTO? data = box.get(0);
  print('data: ${data!.updateAt}');
  runApp(const HiveTest());
}
class HiveTest extends StatelessWidget {
  const HiveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

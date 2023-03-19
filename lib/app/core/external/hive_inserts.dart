
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import '../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../shared/components/splash/infra/use-cases/databases_use_cases.dart';
import '../infra/repositories/repository.dart';
import 'hive_datasource.dart';

//command to map hive entities
// flutter packages pub run build_runner build --delete-conflicting-outputs

Future<DateTime> dateNow() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => DateTime.now(),
  );
}

Future<void> main() async {
  await Hive.initFlutter();
  /*Hive.registerAdapter(
    DatabaseConfigsHiveDTOAdapter(),
  );*/

  HiveDatasource.initHive();

  await Hive.openBox<DatabaseConfigsHiveDTO>('database-configs');
  HiveDatasource hive = HiveDatasource<DatabaseConfigsHiveDTO>(boxLabel: 'database-configs');
  /*Box<DatabaseConfigsHiveDTO> box = Hive.box<DatabaseConfigsHiveDTO>('database-configs');
  box.put(0, DatabaseConfigsHiveDTO(updateAt: DateTime.now()));
  DatabaseConfigsHiveDTO? data = box.get(0);*/
  hive.add('database-configs', DatabaseConfigsHiveDTO(updateAt: DateTime.now()));
  //DatabaseConfigsHiveDTO? data = hive.get('updateAt');
  //hive.delete('updateAt');
  DatabasesUseCases data = DatabasesUseCases(
      repository: Repository(
         datasource: hive
      ));
  DatabaseConfigsHiveDTO? aa = data.get('database-configs');
  print('data: ${aa!.updateAt}');
  runApp(const HiveTest());
}
class HiveTest extends StatelessWidget {
  const HiveTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

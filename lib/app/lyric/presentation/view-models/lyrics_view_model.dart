import '../../../shared/components/utils/validation_util.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

import '../../../splash/presentation/blocs/database_bloc.dart';
import '../../infra/models/hive-dtos/database_configs_hive_dto.dart';

class LyricsViewModel{
  final String database = 'firebase';
  createInstances(DateTime dataUpdateAt) async {
    /*if (ValidationUtil.validationDatasource() == database || DateFormat('y').format(dataUpdateAt) != '2000') {
      DateTime fireUpdateAt = await ValidationUtil.verifyUpdateFirebase(context, dataUpdateAt);
      if(dataUpdateAt.isBefore(fireUpdateAt)){
        databaseBloc.add(AddDataEvent(path: url, data: DatabaseConfigsHiveDTO(updateAt: fireUpdateAt)));
      }
    }*/
  }
}
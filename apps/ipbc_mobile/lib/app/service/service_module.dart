import 'package:core_module/core_module.dart' ;

import '../shared/view-models/services_view_model.dart';
import 'blocs/services_list_bloc.dart';
import 'blocs/services_collection_bloc.dart';

class ServiceModule extends Module {

  @override
  void binds(i) {
    i.addSingleton<ServicesViewModel>(
      () => ServicesViewModel(
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
    );
    i.addSingleton<ServicesCollectionBloc>(
      () => ServicesCollectionBloc(
        fireUseCases: ServiceUseCases(
          repository: i.get<Repository<List<Map>>>(),
        ),
        hiveUseCases: ServiceUseCases(
          repository: Repository(
            datasource:
                HiveDatasource<HiveCollectionDTO>(boxLabel: 'collection'),
          ),
        ),
        viewModel: i.get<ServicesViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );

    i.addSingleton<ServicesListBloc>(
      () => ServicesListBloc(
        fireUseCases: ServicesUseCases(
          repository: i.get<Repository<List<Map>>>(),
        ),
        hiveUseCases: ServicesUseCases(
          repository: Repository(
            datasource: HiveDatasource<HiveServicesDTO>(boxLabel: 'services'),
          ),
        ),
        viewModel: i.get<ServicesViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

}

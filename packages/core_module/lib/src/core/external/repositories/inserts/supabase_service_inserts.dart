/* import 'package:flutter/material.dart';

import '../../../../../core_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseRepository.init();
  SupabaseRepository supa = SupabaseRepository(
    supabaseClient: Supabase.instance.client,
  );
   List<LiturgyEntity> liturgiesList = [
      LiturgyModel(
        id: '0',
        isAdditional: false,
        sequence: 'Oração',
        additional: '',
      ),
      LiturgyModel(
        id: '1',
        isAdditional: true,
        sequence: 'Texto Bíblico',
        additional: 'João 10:1-6',
      ),
    ];

  ServiceEntity serviceEntity = ServiceEntity(
    id: '4',
    image: '',
    theme: '',
    serviceDate: DateTime.now(),
    liturgiesList: liturgiesList,
    serviceLiturgiesTableId: '4',
    liturgiesTableId:'1',
    preacher: '',
    type: '',
    guideIsVisible: liturgiesList.isNotEmpty,
   createAt: DateTime.now(),
    title: '',
    heading:   '',
  );

 final liturgyResponse = await supa.upsert(
    params: {'table': 'liturgies', 'selectFields': 'id'},
    data: LiturgyAdapter.supabaseToMap(
      LiturgySupabase(
        id: serviceEntity.liturgiesTableId,
        liturgy: LiturgyAdapter.toMapList(liturgiesList),
      ),
    ),
  );

  final serviceResponse = await supa.upsert(
    params: {'table': 'service', 'selectFields': 'id'},
    data: ServiceAdapter.toMap(serviceEntity),
  );

  await supa.upsert(
    params: {'table': 'service_liturgies', 'selectFields': 'id'},
    data: ServiceAdapter.serviceLiturgiesToMap(
      ServiceLiturgiesSupabase(
        id: serviceEntity.serviceLiturgiesTableId,
        liturgyId: liturgyResponse[0]['id'],
        serviceId: serviceResponse[0]['id'],
      ),
    ),
  );

 /* if(!isEditing){
    await supa.update(
      data: {
        'service_liturgies_table_id': auxResponse[0]['id'],
        'liturgies_table_id': liturgyResponse[0]['id'],
      },
      params: {
        'table': 'service',
        'referenceField': 'id',
        'referenceValue': serviceResponse[0]['id'],
        'selectFields': 'id',
      },
    );
  }*/
}
*/

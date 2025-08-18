import 'package:flutter/material.dart';

import '../../../../../core_module.dart';
import '../../../../shared/utils/supa_events_util.dart';

//import '../../infra/models/event_model.dart';
// ignore_for_file: avoid_print

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseRepository.init();
  SupabaseRepository supa = SupabaseRepository(
    supabaseClient: Supabase.instance.client,
  );
  bool isEditing = true;
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

  ServiceEntity? serviceEntity;
  bool isServiceNotNull = (serviceEntity != null);
  serviceEntity = ServiceEntity(
    id: (isEditing && isServiceNotNull) ? serviceEntity?.id : null,
    image: '',
    theme: '',
    serviceDate: DateTime.now(),
    liturgiesList: liturgiesList,
    serviceLiturgiesTableId: isServiceNotNull ? serviceEntity?.serviceLiturgiesTableId : '',
    liturgiesTableId: isServiceNotNull ? serviceEntity?.liturgiesTableId : '',
    preacher: '',
    type: '',
    guideIsVisible: liturgiesList.isNotEmpty,
    createAt: (isEditing && isServiceNotNull) ? serviceEntity!.createAt : DateTime.now(),
    title: '',
    heading: '',
  );

  final liturgyResponse = await supa.upsert(
    params: {'table': 'liturgies', 'selectFields': 'id'},
    data: LiturgyAdapter.supabaseToMap(
      LiturgySupabase(
        id: isEditing ? serviceEntity.liturgiesTableId : null,
        liturgy: LiturgyAdapter.toMapList(liturgiesList),
      ),
    ),
  );

  final serviceResponse = await supa.upsert(
    params: {'table': 'service', 'selectFields': 'id'},
    data: ServiceAdapter.toMap(serviceEntity),
  );

  final auxResponse = await supa.upsert(
    params: {'table': 'service_liturgies', 'selectFields': 'id'},
    data: ServiceAdapter.serviceLiturgiesToMap(
      ServiceLiturgiesSupabase(
        id: isEditing
            ? serviceEntity.serviceLiturgiesTableId
            : null,
        liturgyId: liturgyResponse[0]['id'],
        serviceId: serviceResponse[0]['id'],
      ),
    ),
  );

  if(!isEditing){
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
  }
  /*final dadosDoTeste = {
    // A CHAVE DO MISTÉRIO ESTÁ AQUI
    'id': 1,  // << TESTE 1: Deixamos como NÚMERO (int)

    'liturgy': [ // Substitua por um valor real e simples da sua liturgia
      {'sequence': 'Teste de Atualização Direta', 'isAdditional': false, 'id': 'temp1'}
    ]
  };

  try {
    print('Tentando upsert com ID TIPO INT: $dadosDoTeste');

    final response = await supa.upsert(data: dadosDoTeste, params: {'table':'liturgies'});

    print('✅ SUCESSO NO TESTE: A operação foi concluída!');
    print('Resposta do Supabase: $response');

  } catch (e) {
    print('❌ ERRO NO TESTE: Ocorreu uma exceção.');
    print(e);
  }
  print('--- FIM DO TESTE LIMPO ---');*/
}

/*List<Map<String,dynamic>> servicesList = await SupaServicesUtil.servicesListFilled();
    for (Map serviceMetadata in servicesList) {
      supa.add('services', serviceMetadata);
    }
  print('Services list have been successfully added');
  */

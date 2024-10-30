import 'package:flutter/material.dart';

import '../../../../core_module.dart';
import '../../../shared/utils/supa_events_util.dart';
import '../../infra/adapters/supa/supa_event_adapter.dart';
//import '../../infra/models/event_model.dart';
// ignore_for_file: avoid_print

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseDatasource.init();
  SupabaseDatasource supa =
  SupabaseDatasource(supabaseClient: Supabase.instance.client);
  try {
    List<EventEntity> eventsInserted =
    await SupaEventsUtil.loadEventsList(
        'assets/data/events/events_mock.json');
    // inserindo lista de todas as letras
    for (EventEntity event in eventsInserted) {
      supa.add('event', SupaEventAdapter.toMap(event));
    }
    print('events list have been successfully added');
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
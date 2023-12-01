
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core_module.dart';

class SupabaseDatasource implements IDatasource{

  static const supabaseUrl = 'YOUR_SUPABASE_URL';
  static const supabaseKey = 'YOUR_ANON_KEY';

  static late final SupabaseClient supaClient;

  static Future init() async{
   await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
   supaClient = Supabase.instance.client;
  }

  Future<String> verifyUpdateDatasource() async {
    String id = '';
    supaClient
        .from('settings')
        .stream(primaryKey: ['id'])
        .listen((snapshot) {
      id = snapshot.first.toString();
    });
    return id;
  }

  @override
  Future get(String path) async{
    final data = await supaClient.from('countries').select().order('name', ascending: true);
    print(data);
    return '';
  }

  @override
  Future<void> add(String path, data) async{
    await supaClient.from('countries').insert([
      {'name': 'Singapore'},
    ]);
  }

  @override
  Future<void> update(String path, data) async{
    await supaClient.from('countries').update({'name': 'Singapore'}).eq('id', 1);
  }

  @override
  Future<void> delete(String path) async{
    await supaClient.from('countries').delete().eq('id', 1);
  }
}
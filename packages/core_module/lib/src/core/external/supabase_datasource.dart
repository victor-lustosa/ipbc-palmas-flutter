import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core_module.dart';
import '../../configs/api_keys.dart';

class SupabaseDatasource implements IDatasource {

  SupabaseDatasource({required SupabaseClient supabaseClient}) : _supaClient = supabaseClient;

  late final SupabaseClient _supaClient;

  List<String> params = [];

  static Future init() async {
    await Supabase.initialize(url: ApiKeys.supabaseUrl, anonKey: ApiKeys.supabaseKey);
  }

  @override
  Future<List<dynamic>> get(String path) async {
    params = path.split('/');
    final data;
    if(params.length > 3){
      data = await _supaClient.from(params[0]).select().eq(params[1],params[2]).order(params[4], ascending: params[5].toLowerCase() == 'true');
      print(data);
    } else{
      data = await _supaClient.from(params[0]).select().order(params[1], ascending: params[2].toLowerCase() == 'true');
    }
    return Future.value(data);
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    await _supaClient.from(params[0]).insert(data);
  }

  @override
  Future<void> update(String path, data) async {
    params = path.split('/');
    await _supaClient.from(params[0]).update(data).eq(params[1], params[2]);
  }

  @override
  Future<void> delete(String path) async {
    params = path.split('/');
    await _supaClient.from(params[0]).delete().eq(params[1], params[2]);
  }
}

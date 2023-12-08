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
  Future<Map<String, dynamic>> get(String path) async {
    params = path.split('/');
    Map<String,dynamic> result = {};
    if(params.length > 3){
      final data = await _supaClient.from(params[0]).select().eq(params[1],params[2]).order(params[4], ascending: params[5].toLowerCase() == 'true');
      print(data);
    } else{
      final data = await _supaClient.from(params[0]).select().order(params[1], ascending: params[2].toLowerCase() == 'true');
      print(data);
    }
    return result;
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

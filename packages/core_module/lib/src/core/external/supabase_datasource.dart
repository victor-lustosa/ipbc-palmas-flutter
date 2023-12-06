import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core_module.dart';

class SupabaseDatasource implements IDatasource {
  static const supabaseUrl = 'YOUR_SUPABASE_URL';
  static const supabaseKey = 'YOUR_ANON_KEY';

  SupabaseDatasource({required SupabaseClient supabaseClient}) : _supaClient = supabaseClient;

  late final SupabaseClient _supaClient;

  List<String> params = [];

  static Future init() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  }

  @override
  Future<Map<String, dynamic>> get(String path) async {
    params = path.split('/');
    Map<String,dynamic> result = {};
    final data = await _supaClient.from(params[0]).select().order(params[1], ascending: params[3].toLowerCase() == 'true');
    print(data);
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

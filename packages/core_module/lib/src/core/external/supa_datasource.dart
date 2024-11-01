import 'dart:math';

import '../../../core_module.dart';

class SupabaseDatasource implements IDatasource {
  SupabaseDatasource({required SupabaseClient supabaseClient})
      : _supaClient = supabaseClient;

  late final SupabaseClient _supaClient;
  List<String> params = [];

  static Future init() async {
    await Supabase.initialize(
      url: ApiKeys.supabaseUrl,
      anonKey: ApiKeys.supabaseKey,
    );
  }

  @override
<<<<<<< HEAD
  Future<List<dynamic>> get(
    String path,
  ) async {
=======
  Future<List<dynamic>> get(String path) async {

>>>>>>> develop
    params = path.split('/');
    final dynamic data;
    if (params.length > 3) {
      data = await _supaClient
          .from(params[0])
          .select()
          .eq(params[1], params[2])
          .order(params[3], ascending: params[4].toLowerCase() == 'true');
    } else {
      int limit = int.parse(params[1]);
      int offset = params.length > 1 ? int.parse(params[2]) : 0;
      //Entrando aqui
      data = await _supaClient.from(params[0]).select();
      // .range(0, 9);
      // .order(params[1], ascending: true);
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

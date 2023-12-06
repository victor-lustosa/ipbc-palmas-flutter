import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core_module.dart';

class SupabaseDatasource implements IDatasource {
  static const supabaseUrl = 'YOUR_SUPABASE_URL';
  static const supabaseKey = 'YOUR_ANON_KEY';

  static late final SupabaseClient supaClient;
  List<String> params = [];

  static Future init() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
    supaClient = Supabase.instance.client;
  }

  @override
  Future<dynamic> get(String path) async {
    params = path.split('/');
    var result = [];
    final data = await supaClient.from(params[0]).select().order(params[1], ascending: bool.parse(params[3]));
    print(data);
    return result;
  }

  @override
  Future<void> add(String path, data) async {
    params = path.split('/');
    await supaClient.from(params[0]).insert(data);
  }

  @override
  Future<void> update(String path, data) async {
    params = path.split('/');
    await supaClient.from(params[0]).update(data).eq(params[1], params[2]);
  }

  @override
  Future<void> delete(String path) async {
    params = path.split('/');
    await supaClient.from(params[0]).delete().eq(params[1], params[2]);
  }
}

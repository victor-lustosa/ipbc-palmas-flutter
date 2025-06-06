import '../../../../core_module.dart';

class SupabaseRepository implements IRepository {
  SupabaseRepository({required SupabaseClient supabaseClient})
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
  Future<List<dynamic>> get<T>({String? path}) async {
    path ??= '';
    params = path.split('/');
    final dynamic data;
    if (params.length > 3) {
       if(params[0] == 'service') {
         data = await _supaClient
             .from(params[0])
             .select(params[5])
             .eq(params[1], params[2])
             .order(params[3], ascending: params[4].toLowerCase() == 'true');
       } else if(params[0] == 'lyrics') {
         data = await _supaClient
             .from(params[0])
             .select(params[3])
             .order(params[1], ascending: params[2].toLowerCase() == 'true');
      } else {
        data = await _supaClient
            .from(params[0])
            .select()
            .eq(params[1], params[2])
            .order(params[3], ascending: params[4].toLowerCase() == 'true');
      }
    } else {
      data = await _supaClient
          .from(params[0])
          .select()
          .order(params[1], ascending: params[2].toLowerCase() == 'true');
    }
    return Future.value(data);
  }

  @override
  Future<void> add<T>({required data, String? path}) async {
    path ??= '';
    params = path.split('/');
    await _supaClient.from(params[0]).insert(data);
  }

  @override
  Future<void> update<T>({required data, String? path}) async {
    path ??= '';
    params = path.split('/');
    await _supaClient.from(params[0]).update(data).eq(params[1], params[2]);
  }

  @override
  Future<void> delete<T>({String? path}) async {
    path ??= '';
    params = path.split('/');
    await _supaClient.from(params[0]).delete().eq(params[1], params[2]);
  }

  @override
  Future getByPagination<T>({String? path}) async {
    path ??= '';
    params = path.split('/');
    final dynamic data;
   // int limit = int.parse(params[1]);
    //int offset = params.length > 1 ? int.parse(params[2]) : 0;
    data = await _supaClient
        .from(params[0])
        .select()
        .range(0, 9)
        .order(params[1], ascending: true);
    return Future.value(data);
  }
}

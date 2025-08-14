import 'dart:io';

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
  Future<dynamic> get<T>({Map<String, dynamic>? query}) async {
    if (query == null || query['table'] == null) {
      throw ArgumentError('O parâmetro "table" é obrigatório.');
    }
    return _fetchFromSupabase(query);
  }

  Future<List<dynamic>> _fetchFromSupabase(Map<String, dynamic> params) async {
    dynamic query = _supaClient
        .from(params['table'])
        .select(params['selectFields'] ?? '*');
    if (params['filterColumn'] != null && params['filterValue'] != null) {
      query = query.eq(params['filterColumn'], params['filterValue']);
    }
    if (params['orderBy'] != null) {
      query = query.order(
        params['orderBy'],
        ascending: params['ascending'] ?? true,
      );
    }
    if (params['limit'] != null) {
      query = query.limit(params['limit']);
    }
    return await query;
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

  @override
  Future<String?> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  }) async {
    try {
      await Supabase.instance.client.storage
          .from(bucketName)
          .upload(fileName, coverImage);

      final publicUrl = Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Erro ao fazer upload: $e');
      return null;
    }
  }
}

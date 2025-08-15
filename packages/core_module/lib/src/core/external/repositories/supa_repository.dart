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
  Future<dynamic> get<T>({Map<String, dynamic>? params}) async {
    dynamic query = _supaClient
        .from(params?['table'])
        .select(params?['selectFields'] ?? '*');
    if (params?['filterColumn'] != null && params?['filterValue'] != null) {
      query = query.eq(params?['filterColumn'], params?['filterValue']);
    }
    if (params?['orderBy'] != null) {
      query = query.order(
        params?['orderBy'],
        ascending: params?['ascending'] ?? true,
      );
    }
    if (params?['limit'] != null) {
      query = query.limit(params?['limit']);
    }
    return await query;
  }

  @override
  Future<void> add<T>({required data, Map<String, dynamic>? params}) async {
    await _supaClient.from(params?['table']).insert(data);
  }

  @override
  Future<void> update<T>({required data, Map<String, dynamic>? params}) async {
    await _supaClient.from(params?['table']).update(data).eq(params?['filterColumn'], params?['filterValue']);
  }

  @override
  Future<void> delete<T>({Map<String, dynamic>? params}) async {
    await _supaClient.from(params?['table']).delete().eq(params?['filterColumn'], params?['filterValue']);
  }

  @override
  Future getByPagination<T>({Map<String, dynamic>? params}) async {
    // int limit = int.parse(params[1]);
    //int offset = params.length > 1 ? int.parse(params[2]) : 0;
     final dynamic data = await _supaClient
        .from(params?['table'])
        .select()
        .range(0, 9)
        .order(params?['orderBy'], ascending: params?['ascending'] ?? true);
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

      return Supabase.instance.client.storage
          .from(bucketName)
          .getPublicUrl(fileName);
    } catch (e) {
      print('Erro ao fazer upload: $e');
      return null;
    }
  }
}

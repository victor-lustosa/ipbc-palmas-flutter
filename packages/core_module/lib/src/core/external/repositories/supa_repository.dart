import 'dart:io';

import '../../../../core_module.dart';

class SupabaseRepository implements IRepository {
  SupabaseRepository({required SupabaseClient supabaseClient})
    : _supaClient = supabaseClient;

  late final SupabaseClient _supaClient;

  static Future init() async {
    await Supabase.initialize(
      url: ApiKeys.supabaseUrl,
      anonKey: ApiKeys.supabaseKey,
    );
  }

  @override
  Future<Either<dynamic, GenericException>> get<T>({
    Map<String, dynamic>? params,
  }) async {
    try {
      dynamic query = _supaClient
          .from(params?['table'])
          .select(params?['selectFields'] ?? '*');

      if (params?['filterColumn'] != null && params?['filterValue'] != null) {
        query = query.eq(params?['filterColumn'], params?['filterValue']);
      }

      if (params?['likeColumn'] != null && params?['likeValue'] != null) {
        query = query.ilike(params?['likeColumn'], '%${params?['likeValue']}%');
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

      return left(await query);
    } on PostgrestException catch (e) {
      return right(
        GenericException(details: e.details, message: e.message, code: e.code),
      );
    }
  }

  @override
  Future<Either<dynamic, GenericException>> upsert<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    try {
      dynamic query = _supaClient.from(params?['table']).upsert(data);

      if (params?['selectFields'] != null) {
        query = query.select(params?['selectFields'] ?? '*');
      }

      return left(await query);
    } on PostgrestException catch (e) {
      return right(
        GenericException(details: e.details, message: e.message, code: e.code),
      );
    }
  }

  @override
  Future<Either<dynamic, GenericException>> add<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    try {
      dynamic query = _supaClient.from(params?['table']).insert(data);

      if (params?['selectFields'] != null) {
        query = query.select(params?['selectFields'] ?? '*');
      }

      return left(await query);
    } on PostgrestException catch (e) {
      return right(
        GenericException(details: e.details, message: e.message, code: e.code),
      );
    }
  }

  @override
  Future<Either<dynamic, GenericException>> update<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    try {
      dynamic query = _supaClient.from(params?['table']).update(data);

      if (params?['referenceField'] != null &&
          params?['referenceValue'] != null) {
        query = query.eq(params?['referenceField'], params?['referenceValue']);
      }

      if (params?['selectFields'] != null) {
        query = query.select(params?['selectFields'] ?? '*');
      }

      return left(await query);
    } on PostgrestException catch (e) {
      return right(
        GenericException(details: e.details, message: e.message, code: e.code),
      );
    }
  }

  @override
  Future<Either<dynamic, GenericException>> delete<T>({
    Map<String, dynamic>? params,
  }) async {
    try {
      dynamic query = _supaClient.from(params?['table']).delete();

      if (params?['match'] != null &&
          params!['match'] is Map<String, dynamic>) {
        query = query.match(params['match']);
      } else if (params?['whereClause'] != null &&
          params?['referenceValue'] != null) {
        query = query.eq(params?['whereClause'], params?['referenceValue']);
      }
      if (params?['selectFields'] != null) {
        query = query.select(params?['selectFields'] ?? '*');
      }
      return left(await query);
    } on PostgrestException catch (e) {
      return right(
        GenericException(details: e.details, message: e.message, code: e.code),
      );
    }
  }

  @override
  Future<Either<List<T>, GenericException>> getByPagination<T>({
    Map<String, dynamic>? params,
  }) async {
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
  Future<Either<String?, GenericException>> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  }) async {
    try {
      await Supabase.instance.client.storage
          .from(bucketName)
          .upload(fileName, coverImage);

      return left(
        Supabase.instance.client.storage
            .from(bucketName)
            .getPublicUrl(fileName),
      );
    } catch (e) {
      if (e is StorageException) {
        return right(
          GenericException(
            message: e.message,
            code: e.statusCode,
            details: e.error,
          ),
        );
      } else if (e is SocketException) {
        return right(
          GenericException(
            message: e.message,
            code: 'NO_INTERNET',
            details: e.osError?.toString(),
          ),
        );
      }
      return right(GenericException(message: "Erro desconhecido: $e"));
    }
  }
}

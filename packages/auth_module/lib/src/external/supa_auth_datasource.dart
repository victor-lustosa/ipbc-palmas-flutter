
import 'package:auth_module/src/infra/datasources/auth_datasource.dart';
import 'package:core_module/core_module.dart';

class SupaAuthDatasource implements IAuthDatasource {
  SupaAuthDatasource({required SupabaseClient supaClient})
      : _supaClient = supaClient;

  late final SupabaseClient _supaClient;

  List<String> params = [];

  @override
  Future<String> signInWithEmail(String email, String password) async {
    final AuthResponse res = await _supaClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res.session?.accessToken != null
        ? res.session!.accessToken
        : '';
  }

}

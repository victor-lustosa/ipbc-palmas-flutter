
import 'package:core_module/core_module.dart';

class SupabaseAuthDatasource implements IAuth {
  SupabaseAuthDatasource({required SupabaseClient supabaseClient})
      : _supaClient = supabaseClient;

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

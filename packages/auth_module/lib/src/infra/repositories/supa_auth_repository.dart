
import 'package:core_module/core_module.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/repositories/auth_repositories.dart';

class SupaAuthRepository implements IOnlineAuthRepository{

  SupaAuthRepository({required SupabaseClient supaClient})
      : _supaClient = supaClient;

  late final SupabaseClient _supaClient;

  @override
  UserEntity? getCurrentUser() {
    User? user = _supaClient.auth.currentUser;
    return UserEntity.create(user);
  }

  @override
  Future<String?> signInWithGoogle() async {

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: ApiKeys.iosCredencial,
      serverClientId: ApiKeys.webCredencial,
    );

    final googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final accessToken = googleAuth?.accessToken;
    final idToken = googleAuth?.idToken;

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    if (accessToken == null) {
      throw 'No Access Token found.';
    }

    await _supaClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    return accessToken;
  }

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

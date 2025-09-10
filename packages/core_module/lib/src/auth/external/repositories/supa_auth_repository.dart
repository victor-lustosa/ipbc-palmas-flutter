import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../infra/repositories/auth_repositories.dart';

const List<String> _scopes = <String>['email', 'profile'];

class SupaAuthRepository implements IOnlineAuthRepository {
  SupaAuthRepository({required SupabaseClient supaClient})
    : _supaClient = supaClient {
    googleSignIn = GoogleSignIn.instance;
  }

  final SupabaseClient _supaClient;
  late final GoogleSignIn googleSignIn;

  @override
  UserEntity? getCurrentUser() {
    User? user = _supaClient.auth.currentUser;
    if (user == null) return null;
    return UserEntity.create(user);
  }

  @override
  Future<String?> signInWithGoogle() async {
    googleSignIn.initialize(
      clientId: ApiKeys.iosCredencial,
      serverClientId: ApiKeys.webCredencial,
    );
    try {
      GoogleSignInAccount? user = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = user.authentication;
      final GoogleSignInClientAuthorization? authorization = await user
          .authorizationClient
          .authorizationForScopes(_scopes);
      final idToken = googleAuth.idToken;
      final accessToken = authorization?.accessToken;

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
      return idToken;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logoutWithGoogle() async {
    await googleSignIn.signOut();
  }

  @override
  Future<String> signInWithEmail(String email, String password) async {
    final AuthResponse res = await _supaClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res.session?.accessToken != null ? res.session!.accessToken : '';
  }

  @override
  Future<void> signInFacebook() async {
    try {
      await _supaClient.auth.signOut();
      await _supaClient.auth.signInWithOAuth(
        OAuthProvider.facebook,
        scopes: 'public_profile,email',
        queryParams: {'prompt': 'select_account'},
        redirectTo: 'https://xrvmfhpmelyvupfylnfk.supabase.co/auth/v1/callback',
      );
    } catch (e) {
      print('Erro inesperado: $e');
    }
  }

  @override
  Stream streamFacebook() {
    return _supaClient.auth.onAuthStateChange;
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart'; // Import necessário para kIsWeb

class AuthService {
  final _supabase = Supabase.instance.client;

  // Sign up with email and password
  Future<AuthResponse> signUp(String email, String password) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password,
    );
  }

  // Sign in with email and password
  Future<AuthResponse> signIn(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
  
  // Sign in with Google (OAuth2)
  Future<AuthResponse?> signInWithGoogle() async {
    const webClientId = 'my-web.apps.googleusercontent.com'; // TODO: Coloque sua chave
    const iosClientId = 'my-ios.apps.googleusercontent.com'; // TODO: Coloque sua chave

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: kIsWeb ? webClientId : iosClientId,
      serverClientId: kIsWeb ? null : webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw 'Login cancelado pelo usuário.';
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get current user
  User? get currentUser => _supabase.auth.currentUser;
}

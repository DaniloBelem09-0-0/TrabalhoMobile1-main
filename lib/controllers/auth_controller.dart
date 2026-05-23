import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<void> signIn(String email, String password) async {
    await _authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    await _authService.signUp(email, password);
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = '';
  String _userEmail = '';

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;

  Future<bool> loginWithEmail(String email, String password) async {
    // محاكاة استدعاء API
    await Future.delayed(const Duration(seconds: 1));
    // محاكاة نجاح إذا كان البريد يحتوي @ وكلمة المرور 6+
    if (email.contains('@') && password.length >= 6) {
      _isLoggedIn = true;
      _userName = email.split('@')[0];
      _userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> loginWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    _userName = 'مستخدم Google';
    _userEmail = 'user@gmail.com';
    notifyListeners();
    return true;
  }

  void logout() {
    _isLoggedIn = false;
    _userName = '';
    _userEmail = '';
    notifyListeners();
  }
}
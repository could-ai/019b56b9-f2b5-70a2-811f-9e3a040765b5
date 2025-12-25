import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Mock login with invitation code
  Future<bool> loginWithInvitation(String code) async {
    // Mock: In real app, verify code with backend
    if (code == 'invite123') {
      _currentUser = User(
        id: '1',
        name: 'Jane Doe',
        email: 'jane@example.com',
        position: 'CEO',
        isAdmin: false,
        isApproved: true,
      );
      notifyListeners();
      return true;
    } else if (code == 'admin123') {
      _currentUser = User(
        id: 'admin',
        name: 'Admin',
        email: 'admin@example.com',
        position: 'Admin',
        isAdmin: true,
        isApproved: true,
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

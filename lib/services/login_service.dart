import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginService extends ChangeNotifier {
  User? usuario;
  String? emailCompleted;
  String? passwordCompleted;

  LoginService() {
    apiLogin(email: '', password: '');
  }

  Future<User?> apiLogin(
      {required String email, required String password}) async {
    print('email: $email senha: $password');
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      usuario = FirebaseAuth.instance.currentUser;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      emailCompleted = null;
      passwordCompleted = null;
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {}
    }

    return usuario;
  }
}

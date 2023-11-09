import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/modules/login/usuario_shared.dart';

class LoginService extends ChangeNotifier {
  User? usuario;
  final shared = UsuarioShared();

  LoginService({this.usuario});

  Future<void> apiLogin(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      usuario = FirebaseAuth.instance.currentUser;
      shared.setUsuario(usuario.toString());
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print('erro: ${e.code}');
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {}
    }
  }
}

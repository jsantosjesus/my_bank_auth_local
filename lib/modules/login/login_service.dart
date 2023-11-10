import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/modules/login/usuario_shared.dart';

class LoginService extends ChangeNotifier {
  String? usuario;
  final shared = UsuarioShared();

  // LoginService({this.usuario});

  Future<void> apiLogin(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      usuario = FirebaseAuth.instance.currentUser.toString();
      shared.setUsuario(usuario.toString());
      notifyListeners();
      if (usuario != null) print(usuario);
    } on FirebaseAuthException catch (e) {
      print('erro: ${e.code}');
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {}
    }
  }

  authLogin(preUser) {
    usuario = preUser;
    notifyListeners();
    print(usuario);
  }
}

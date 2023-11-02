import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  String? email;
  String? password;
  final formKey = GlobalKey<FormState>();
  var _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    onUpdate();
  }

  final VoidCallback onSuccessLogin;
  final VoidCallback onUpdate;

  LoginController({required this.onSuccessLogin(), required this.onUpdate});
  void login() async {
    print('conectando ao servidor');
    isLoading = true;
    bool response = await apiLogin(email: email!, password: password!);
    isLoading = false;
    if (response) {
      onSuccessLogin();
    }
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  String? validateEmail(String? email) =>
      email != null && email.isNotEmpty ? null : 'O campo email é obrigatorio!';
  String? validatePassword(String? password) =>
      password != null && password.length > 5
          ? null
          : 'A senha precisa ter pelo menos seis caracteres';

  Future<bool> apiLogin(
      {required String email, required String password}) async {
    final response = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(response);
    return true;
  }
}

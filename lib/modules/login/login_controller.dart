import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LoginController {
  String? email;
  String? password;
  String? emailCompleted;
  String? passwordCompleted;
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
    emailCompleted = email;
    passwordCompleted = password;
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

  //login with auth_local
  late final LocalAuthentication auth;
  bool supportState = false;
  bool erro = false;

  testDeviceSupported() async {
    auth = LocalAuthentication();
    await auth.isDeviceSupported().then((bool isSupported) {
      // setState(() {
      supportState = isSupported;
      onUpdate();
      print('suporta: $supportState');
      // })
    }).catchError((onError) => {print('erro: $onError')});
  }

  Future<void> authenticate() async {
    if (supportState) {
      try {
        bool authenticated = await auth.authenticate(
            localizedReason: 'teste',
            options: const AuthenticationOptions(
                stickyAuth: true, biometricOnly: false));
        if (authenticated) {
          bool response = await apiLogin(
              email: emailCompleted!, password: passwordCompleted!);
          isLoading = false;
          if (response) {
            onSuccessLogin();
          }
        }
        print("Autenticado: $authenticated");
      } on PlatformException catch (err) {
        print("errro: $err");
      }
    } else {
      print('esse device não suporta biometria ou faceId');
    }
  }

  Future<void> getAvailableBiometrics() async {
    if (supportState) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      print("List of AvailableBiometrics : $availableBiometrics");
    } else {
      print('getbiometric: none');
    }
  }
}

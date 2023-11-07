import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_bank_auth_local/services/login_service.dart';

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

  final service = LoginService();

  bool userNotFound = false;

  final VoidCallback onSuccessLogin;
  final VoidCallback onUpdate;

  LoginController({required this.onSuccessLogin(), required this.onUpdate});

  //chamando login atraves do preenchimento de email e senha
  void login() async {
    print('conectando ao servidor');
    isLoading = true;
    emailCompleted = email;
    passwordCompleted = password;
    await service.apiLogin(email: email!, password: password!);
    isLoading = false;
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

//validando tamanho de email e senha antes de enviar para o usuario
  String? validateEmail(String? email) =>
      email != null && email.isNotEmpty ? null : 'O campo email é obrigatorio!';
  String? validatePassword(String? password) =>
      password != null && password.length > 5
          ? null
          : 'A senha precisa ter pelo menos seis caracteres';

  // Future<bool> apiLogin(
  //     {required String email, required String password}) async {
  //   bool response;
  //   print('apiLogin');
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     usuario = FirebaseAuth.instance.currentUser;
  //     print(usuario);
  //     response = true;
  //     userNotFound = false;
  //   } on FirebaseAuthException catch (e) {
  //     emailCompleted = null;
  //     passwordCompleted = null;
  //     onUpdate();
  //     print('erro: ${e.code}');
  //     if (e.code == "INVALID_LOGIN_CREDENTIALS") {
  //       userNotFound = true;
  //       onUpdate();
  //     }
  //     response = false;
  //   }

  //   return response;
  // }

  //login com auth_local
  late final LocalAuthentication auth;
  bool supportState = false;
  bool erro = false;

  //testando se o dispositivo suporta e está configurado biometria ou faceID
  testDeviceSupported() async {
    auth = LocalAuthentication();
    await auth.isDeviceSupported().then((bool isSupported) {
      supportState = isSupported;
      onUpdate();
      print('suporta: $supportState');
    })
        // .catchError((onError) => {})
        ;
  }

  //realizando autenticação com auth_local
  Future<void> authenticate() async {
    if (supportState) {
      try {
        bool authenticated = await auth.authenticate(
            localizedReason: 'teste',
            options: const AuthenticationOptions(
                stickyAuth: true, biometricOnly: false));
        if (authenticated) {
          await service.apiLogin(
              email: emailCompleted!, password: passwordCompleted!);
          isLoading = false;
        }
        // print("Autenticado: $authenticated");
      } on PlatformException catch (err) {
        print("errro: $err");
      }
    } else {
      print('esse device não suporta biometria ou faceId');
    }
  }
}

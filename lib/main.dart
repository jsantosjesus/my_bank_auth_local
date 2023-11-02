import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppWidget());
  // final isValid = validate(email: 'email', password: 'password');
  // if (isValid == null) {
  //   login(email: 'email', password: 'password');
  // }
}



// login

// void login({required email, required String? password}) {
//   bool response = validateLogin(email: 'email', password: 'password');
//   if (response) {
//     print('abrindo a homePage');
//   }
// }

// String? validate({String? email, String? password}) {
//   final passwordIsValid = validatePassword(password);
//   final emailIsValid = validateEmail(email);

//   if (passwordIsValid == false) {
//     return 'A senha precisa ter pelo menos seis digitos';
//   }
//   if (emailIsValid == false) {
//     return 'O campo email é obrigatorio!';
//   }

//   return null;
// }

// bool validateEmail(String? email) => email != null && email.length > 0;
// bool validatePassword(String? password) =>
//     password != null && password.length > 6;

// bool validateLogin({required String email, required String password}) {
//   print('conectando ao servidor');
//   return true;
// }

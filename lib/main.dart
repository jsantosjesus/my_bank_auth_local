import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/home_page.dart';
import 'package:my_bank_auth_local/login_page.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
  // final isValid = validate(email: 'email', password: 'password');
  // if (isValid == null) {
  //   login(email: 'email', password: 'password');
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometria',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/': (context) => const HomePage()
      },
    );
  }
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

import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/widgets/login_check.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {'/': (context) => const LoginCheck()},
    );
  }
}

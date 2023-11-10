import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/modules/login/login_service.dart';
import 'package:my_bank_auth_local/widgets/login_check.dart';

class AppWidget extends StatelessWidget {
  AppWidget({super.key});

  final LoginService _service = LoginService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {'/login': (context) => LoginCheck(service: _service)},
    );
  }
}

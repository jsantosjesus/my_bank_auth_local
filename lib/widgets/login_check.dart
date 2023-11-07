import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/services/login_service.dart';
import 'package:provider/provider.dart';

import '../modules/home/home_page.dart';
import '../modules/login/login_page.dart';

class LoginCheck extends StatefulWidget {
  const LoginCheck({Key? key}) : super(key: key);

  @override
  LoginCheckState createState() => LoginCheckState();
}

class LoginCheckState extends State<LoginCheck> {
  @override
  Widget build(BuildContext context) {
    LoginService auth = Provider.of<LoginService>(context);

    if (auth.usuario == null)
      return LoginPage();
    else
      return HomePage();
  }
}

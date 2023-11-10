// import 'package:flutter/material.dart';
// import 'package:my_bank_auth_local/modules/home/home_page.dart';
// import 'package:my_bank_auth_local/modules/login/login_page.dart';
// import 'package:my_bank_auth_local/modules/login/login_service.dart';
// import 'package:provider/provider.dart';

// class LoginCheck extends StatefulWidget {
//   const LoginCheck({super.key});

//   @override
//   State<LoginCheck> createState() => _LoginCheckState();
// }

// class _LoginCheckState extends State<LoginCheck> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LoginService>(builder: (context, service, _) {
//       if (service.usuario == null)
//         return LoginPage();
//       else
//         return HomePage();
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/modules/home/home_page.dart';
import 'package:my_bank_auth_local/modules/login/login_page.dart';
import 'package:my_bank_auth_local/modules/login/login_service.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key, required this.service});

  final LoginService service;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: service,
        builder: (BuildContext context, Widget? child) {
          if (service.usuario != null) {
            return HomePage();
          } else {
            return LoginPage();
          }
        });
  }
}

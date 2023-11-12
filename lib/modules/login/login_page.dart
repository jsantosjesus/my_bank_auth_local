import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/modules/login/login_controller.dart';
import 'package:my_bank_auth_local/modules/login/usuario_shared.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userShared = UsuarioShared();
  late final controller = LoginController(onUpdate: () {
    setState(() {});
  }, onSuccessLogin: () {
    Navigator.pushNamed(context, '/');
  });

  @override
  void initState() {
    super.initState();
    controller.testDeviceSupported();
    userShared.startUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.userNotFound)
                const Text('Usuario ou senha invalidos!'),
              TextFormField(
                validator: (value) => controller.validateEmail(value),
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => controller.email = value!,
              ),
              TextFormField(
                validator: (value) => controller.validatePassword(value),
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => controller.password = value!,
              ),
              Container(
                height: 10,
              ),
              if (controller.isLogin) const Text('Ainda não tem conta?'),
              if (controller.isLogin)
                TextButton(
                    onPressed: () {
                      controller.alterLoginForSingup();
                      setState(() {});
                    },
                    child: const Text('cadastre-se')),
              if (!controller.isLogin) const Text('Já tem conta?'),
              if (!controller.isLogin)
                TextButton(
                    onPressed: () {
                      controller.alterLoginForSingup();
                      setState(() {});
                    },
                    child: const Text('Faça login')),
              Container(height: 15),
              if (controller.isLoading)
                const CircularProgressIndicator()
              else
                SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      if (controller.validate()) {
                        controller.login();
                        // setState(() {});
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: const Text('Entrar',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              Container(height: 20.0),
              if (userShared.preUser != null &&
                  controller.supportState &&
                  !controller.isLoading &&
                  controller.isLogin)
                SizedBox(
                  width: 300,
                  child: OutlinedButton(
                    onPressed: () {
                      controller.authenticate(userShared.preUser);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 2.0, color: Colors.blue),
                    ),
                    child: const Text('Login com biometria',
                        style: TextStyle(color: Colors.blue)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

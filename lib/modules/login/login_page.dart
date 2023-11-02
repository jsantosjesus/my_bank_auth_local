import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/modules/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final controller = LoginController(onSuccessLogin: () {
    Navigator.pushNamed(context, '/');
  }, onUpdate: () {
    setState(() {});
  });

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
              Container(height: 20.0),
              if (controller.isLoading)
                const CircularProgressIndicator()
              else
                TextButton(
                  onPressed: () {
                    if (controller.validate()) {
                      controller.login();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text('Login',
                      style: TextStyle(color: Colors.white)),
                )
            ],
          ),
        ),
      ),
    );
  }
}

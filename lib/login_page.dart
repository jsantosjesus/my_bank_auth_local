import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  final formKey = GlobalKey<FormState>();
  var isLoading = false;

  void login({required email, required String? password}) async {
    print('conectando ao servidor');
    isLoading = true;
    setState(() {});
    bool response = await apiLogin(email: 'email', password: 'password');
    isLoading = false;
    setState(() {});
    if (response) {
      Navigator.pushNamed(context, '/');
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
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) => validateEmail(value),
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                validator: (value) => validatePassword(value),
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => password = value!,
              ),
              Container(height: 20.0),
              if (isLoading)
                const CircularProgressIndicator()
              else
                TextButton(
                  onPressed: () {
                    if (validate()) {
                      login(email: email, password: password);
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

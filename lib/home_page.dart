import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  bool erro = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth
        .isDeviceSupported()
        .then((bool isSupported) => setState(() {
              _supportState = isSupported;
              print('suporta: $_supportState');
            }))
        .catchError((onError) => {print('erro: $onError')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometria'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.green),
              child: Text(
                'Confirmar biometria no device',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _getAvailableBiometrics();
              },
            ),
            Container(height: 20.0),
            TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  elevation: 15,
                  shadowColor: Colors.green),
              child: Text(
                'Testar biometria',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _authenticate();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    if (_supportState) {
      try {
        bool authenticated = await auth.authenticate(
            localizedReason: 'teste',
            options:
                AuthenticationOptions(stickyAuth: true, biometricOnly: false));
        print("Autenticado: $authenticated");
      } on PlatformException catch (err) {
        print("errro: $err");
      }
    } else {
      print('esse device não suporta biometria ou faceId');
    }
  }

  Future<void> _getAvailableBiometrics() async {
    if (_supportState) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      print("List of AvailableBiometrics : $availableBiometrics");
    } else {
      print('esse device não suporta biometria ou faceId');
    }
  }
}

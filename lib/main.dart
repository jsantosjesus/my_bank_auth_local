import 'package:flutter/material.dart';
import 'package:my_bank_auth_local/widgets/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_bank_auth_local/services/login_service.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginService()),
    ], child: const AppWidget()),
  );
}

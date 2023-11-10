import 'package:shared_preferences/shared_preferences.dart';

class UsuarioShared {
  late SharedPreferences _prefs;
  String? preUser;

  UsuarioShared() {
    startUsuario();
  }

  startUsuario() async {
    await _startPreferencies();
    await _readUsuario();
  }

  Future<void> _startPreferencies() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _readUsuario() {
    preUser = _prefs.getString('preUser');
  }

  setUsuario(String usuario) async {
    await _prefs.setString('preUser', usuario);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  static Future saveStringData(String value) async {
    _prefs?.setString('token', value);
  }
  static Future getStringData() async {
    return _prefs?.getString('token');
  }
  static Future removeData() async {
    return _prefs?.remove('token');
  }
}

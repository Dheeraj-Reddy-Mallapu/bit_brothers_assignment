import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  String _tokenKey = 'tokenKey';

  Future<bool> saveToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_tokenKey, value);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }
}

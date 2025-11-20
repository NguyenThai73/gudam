import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {

  static Future<bool> getAgreeTerms() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var term = prefs.getBool("term");
    return term ?? false;
  }

  static Future<bool> saveAgreeTerms(bool term) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("term", term);
  }

  static Future<bool> save<T>(String key, T value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is String) {
      return prefs.setString(key, value);
    }
    if (value is int) {
      return prefs.setInt(key, value);
    }
    if (value is double) {
      return prefs.setDouble(key, value);
    }
    if (value is bool) {
      return prefs.setBool(key, value);
    }
    return prefs.setString(key, value.toString());
  }

  static clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
  }

  static clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<T?> getValue<T>(String keyPaymentMethod) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.get(keyPaymentMethod);
    if (value is T) {
      return value;
    }
    return null;
  }
}

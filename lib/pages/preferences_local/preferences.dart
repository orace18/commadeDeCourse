import 'package:shared_preferences/shared_preferences.dart';

class Preference {

  static const String KEY_USERNAME = 'username';
  static const String KEY_NAME = 'name';
  static const String KEY_LASTNAME = 'lastname';
  static const String KEY_MOBILE_NUMBER = 'mobileNumber';
  // Ajoutez d'autres clés selon les besoins

  static Preference _instance = Preference._internal();

  factory Preference() {
    return _instance;
  }

  Preference._internal();

  Future<void> saveUserData({
    required String username,
    required String name,
    required String lastname,
    required String mobileNumber,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(KEY_USERNAME, username);
    await prefs.setString(KEY_NAME, name);
    await prefs.setString(KEY_LASTNAME, lastname);
    await prefs.setString(KEY_MOBILE_NUMBER, mobileNumber);
  }

  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      KEY_USERNAME: prefs.getString(KEY_USERNAME) ?? '',
      KEY_NAME: prefs.getString(KEY_NAME) ?? '',
      KEY_LASTNAME: prefs.getString(KEY_LASTNAME) ?? '',
      KEY_MOBILE_NUMBER: prefs.getString(KEY_MOBILE_NUMBER) ?? '',
    };
  }
}
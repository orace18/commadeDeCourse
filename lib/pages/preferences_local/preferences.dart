import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  
  void init() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
  }
  
}

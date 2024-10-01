import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String? getString(String key) {
    return _prefsInstance.getString(key);
  }

  static List<String>? getStringList(String key) {
    return _prefsInstance.getStringList(key);
  }
}

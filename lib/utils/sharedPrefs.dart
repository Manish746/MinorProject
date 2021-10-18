import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarees/constants.dart';

class StorageUtil {
  static StorageUtil _storageUtil;
  static SharedPreferences _preferences;

  static Future<StorageUtil> getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = StorageUtil._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  StorageUtil._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static String getString(String key) {
    if (_preferences == null) return null;
    return _preferences.getString(key) ?? null;
  }

  // put string
  static Future<bool> setString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.setString(key, value ?? "");
  }

  // clear string
  static Future<bool> clrString() {
    SharedPreferences prefs = _preferences;
    return prefs.clear();
  }

  static initialiseToken() async {
    if (_preferences == null) return;
    try {
      String _token = _preferences.getString(kUserToken);
      if (_token == null) {
        await _preferences.setString(kUserToken, "");
      }
    } catch (e) {
      await _preferences.setString(kUserToken, "");
    }
    return;
  }
}

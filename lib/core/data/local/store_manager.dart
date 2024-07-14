import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_logger.dart';


abstract class StoreManager {
  Future<bool> set(String key, String data);
  String? get(String key);
  Future<bool> delete(String key);
  Future<bool> clear();
}

class SharedPreferencesManager implements StoreManager {
  final SharedPreferences _preferences;
  SharedPreferencesManager(this._preferences);

  static const String _logTag = 'SharedPreferencesManager';

  @override
  Future<bool> clear() async {
    final value = await _preferences.clear();
    logger.d('$_logTag clear() $value');
    return value;
  }

  @override
  Future<bool> delete(String key) async {
    final value = await _preferences.remove(key);
    logger.d('$_logTag delete($key) $value');
    return value;
  }

  @override
  String? get(String key) {
    final value = _preferences.getString(key);
    logger.d('$_logTag get($key) $value');
    return value;
  }

  @override
  Future<bool> set(String key, String data) async {
    final value = await _preferences.setString(key, data);
    logger.d('$_logTag set($key, $data) $value');
    return value;
  }
}
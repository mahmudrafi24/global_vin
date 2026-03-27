import 'package:hive/hive.dart';

class AppSettings {
  static const String _boxName = 'appSettings';
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  // Onboarding
  bool get onboardingDone => _box.get('onboardingDone', defaultValue: false);
  Future<void> setOnboardingDone(bool value) =>
      _box.put('onboardingDone', value);

  // Plan
  String get plan => _box.get('plan', defaultValue: 'basic');
  Future<void> setPlan(String value) => _box.put('plan', value);

  // Unit System
  String get unitSystem => _box.get('unitSystem', defaultValue: 'metric');
  Future<void> setUnitSystem(String value) => _box.put('unitSystem', value);

  // Language
  String get language => _box.get('language', defaultValue: 'en');
  Future<void> setLanguage(String value) => _box.put('language', value);

  // Notifications
  bool get notifications => _box.get('notifications', defaultValue: true);
  Future<void> setNotifications(bool value) =>
      _box.put('notifications', value);

  // Decode count (daily)
  int get decodeCount => _box.get('decodeCount', defaultValue: 0);
  String get decodeDate => _box.get('decodeDate', defaultValue: '');

  Future<void> incrementDecodeCount() async {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (decodeDate != today) {
      await _box.put('decodeDate', today);
      await _box.put('decodeCount', 1);
    } else {
      await _box.put('decodeCount', decodeCount + 1);
    }
  }

  int get todayDecodeCount {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    if (decodeDate != today) return 0;
    return decodeCount;
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}

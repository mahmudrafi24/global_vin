import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/user_profile_entity.dart';

class ProfileLocalDatasource {
  static const String _boxName = 'userProfile';
  static const String _key = 'profile';
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  UserProfileEntity getProfile() {
    final raw = _box.get(_key);
    if (raw is String) {
      return UserProfileEntity.fromMap(jsonDecode(raw));
    }
    return UserProfileEntity.empty();
  }

  Future<void> saveProfile(UserProfileEntity profile) async {
    await _box.put(_key, jsonEncode(profile.toMap()));
  }

  Future<void> clear() async {
    await _box.clear();
  }
}

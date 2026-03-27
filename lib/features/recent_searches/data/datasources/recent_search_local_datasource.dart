import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/recent_search_entity.dart';

class RecentSearchLocalDatasource {
  static const String _boxName = 'recentSearches';
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  List<RecentSearchEntity> getAll() {
    final list = <RecentSearchEntity>[];
    for (var i = 0; i < _box.length; i++) {
      try {
        final raw = _box.getAt(i);
        if (raw is String) {
          list.add(RecentSearchEntity.fromMap(jsonDecode(raw)));
        }
      } catch (_) {}
    }
    list.sort((a, b) => b.searchedAt.compareTo(a.searchedAt));
    return list;
  }

  Future<void> add(RecentSearchEntity search) async {
    // Remove existing entry with same VIN
    await removeByVin(search.vin);
    await _box.add(jsonEncode(search.toMap()));
  }

  Future<void> removeByVin(String vin) async {
    for (var i = _box.length - 1; i >= 0; i--) {
      try {
        final raw = _box.getAt(i);
        if (raw is String) {
          final entity = RecentSearchEntity.fromMap(jsonDecode(raw));
          if (entity.vin == vin) {
            await _box.deleteAt(i);
          }
        }
      } catch (_) {}
    }
  }

  Future<void> clearAll() async {
    await _box.clear();
  }

  Future<void> trimToLimit(int maxCount) async {
    final all = getAll();
    if (all.length > maxCount) {
      await _box.clear();
      final toKeep = all.take(maxCount).toList();
      for (final item in toKeep) {
        await _box.add(jsonEncode(item.toMap()));
      }
    }
  }
}

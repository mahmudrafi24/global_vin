class CacheProvider {
  final Map<String, _CacheEntry> _cache = {};

  void put(String key, dynamic value, {Duration duration = const Duration(minutes: 5)}) {
    _cache[key] = _CacheEntry(
      value: value,
      expiry: DateTime.now().add(duration),
    );
  }

  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null) return null;
    if (DateTime.now().isAfter(entry.expiry)) {
      _cache.remove(key);
      return null;
    }
    return entry.value as T?;
  }

  void remove(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }
}

class _CacheEntry {
  final dynamic value;
  final DateTime expiry;

  _CacheEntry({required this.value, required this.expiry});
}

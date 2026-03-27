class RecentSearchEntity {
  final String vin;
  final String make;
  final String model;
  final String year;
  final DateTime searchedAt;

  const RecentSearchEntity({
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.searchedAt,
  });

  Map<String, dynamic> toMap() => {
        'vin': vin,
        'make': make,
        'model': model,
        'year': year,
        'searchedAt': searchedAt.toIso8601String(),
      };

  factory RecentSearchEntity.fromMap(Map<String, dynamic> map) =>
      RecentSearchEntity(
        vin: map['vin'] ?? '',
        make: map['make'] ?? '',
        model: map['model'] ?? '',
        year: map['year'] ?? '',
        searchedAt: DateTime.parse(
            map['searchedAt'] ?? DateTime.now().toIso8601String()),
      );

  String get timeAgo {
    final diff = DateTime.now().difference(searchedAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${(diff.inDays / 7).floor()}w ago';
  }
}

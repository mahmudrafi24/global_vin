class UserProfileEntity {
  final String name;
  final String email;
  final String phone;
  final String country;
  final String avatarPath;

  const UserProfileEntity({
    required this.name,
    required this.email,
    this.phone = '',
    this.country = '',
    this.avatarPath = '',
  });

  factory UserProfileEntity.empty() => const UserProfileEntity(
        name: 'John Doe',
        email: 'john@example.com',
        phone: '',
        country: 'United States',
        avatarPath: '',
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'country': country,
        'avatarPath': avatarPath,
      };

  factory UserProfileEntity.fromMap(Map<String, dynamic> map) =>
      UserProfileEntity(
        name: map['name'] ?? 'John Doe',
        email: map['email'] ?? 'john@example.com',
        phone: map['phone'] ?? '',
        country: map['country'] ?? '',
        avatarPath: map['avatarPath'] ?? '',
      );

  UserProfileEntity copyWith({
    String? name,
    String? email,
    String? phone,
    String? country,
    String? avatarPath,
  }) =>
      UserProfileEntity(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        country: country ?? this.country,
        avatarPath: avatarPath ?? this.avatarPath,
      );

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }
}

class VinEntity {
  final String vin;
  final String make;
  final String model;
  final String year;
  final String bodyType;
  final String fuelType;
  final String driveType;
  final String transmission;
  final String engine;
  final String engineHp;
  final String cylinders;
  final String doors;
  final String seats;
  final String country;
  final String manufacturer;
  final String plantCity;
  final String color;
  final String vehicleType;
  final List<String> equipment;
  final String safetyRating;
  final List<String> safetyFeatures;
  final String marketValueMin;
  final String marketValueMax;
  final String imageUrl;

  const VinEntity({
    required this.vin,
    required this.make,
    required this.model,
    required this.year,
    required this.bodyType,
    required this.fuelType,
    required this.driveType,
    required this.transmission,
    required this.engine,
    required this.engineHp,
    required this.cylinders,
    required this.doors,
    required this.seats,
    required this.country,
    required this.manufacturer,
    required this.plantCity,
    required this.color,
    required this.vehicleType,
    required this.equipment,
    required this.safetyRating,
    required this.safetyFeatures,
    required this.marketValueMin,
    required this.marketValueMax,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() => {
        'vin': vin,
        'make': make,
        'model': model,
        'year': year,
        'bodyType': bodyType,
        'fuelType': fuelType,
        'driveType': driveType,
        'transmission': transmission,
        'engine': engine,
        'engineHp': engineHp,
        'cylinders': cylinders,
        'doors': doors,
        'seats': seats,
        'country': country,
        'manufacturer': manufacturer,
        'plantCity': plantCity,
        'color': color,
        'vehicleType': vehicleType,
        'equipment': equipment,
        'safetyRating': safetyRating,
        'safetyFeatures': safetyFeatures,
        'marketValueMin': marketValueMin,
        'marketValueMax': marketValueMax,
        'imageUrl': imageUrl,
      };

  factory VinEntity.fromMap(Map<String, dynamic> map) => VinEntity(
        vin: map['vin'] ?? '',
        make: map['make'] ?? '',
        model: map['model'] ?? '',
        year: map['year'] ?? '',
        bodyType: map['bodyType'] ?? '',
        fuelType: map['fuelType'] ?? '',
        driveType: map['driveType'] ?? '',
        transmission: map['transmission'] ?? '',
        engine: map['engine'] ?? '',
        engineHp: map['engineHp'] ?? '',
        cylinders: map['cylinders'] ?? '',
        doors: map['doors'] ?? '',
        seats: map['seats'] ?? '',
        country: map['country'] ?? '',
        manufacturer: map['manufacturer'] ?? '',
        plantCity: map['plantCity'] ?? '',
        color: map['color'] ?? '',
        vehicleType: map['vehicleType'] ?? '',
        equipment: List<String>.from(map['equipment'] ?? []),
        safetyRating: map['safetyRating'] ?? '',
        safetyFeatures: List<String>.from(map['safetyFeatures'] ?? []),
        marketValueMin: map['marketValueMin'] ?? '',
        marketValueMax: map['marketValueMax'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
      );
}

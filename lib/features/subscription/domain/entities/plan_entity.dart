enum PlanType { basic, standard, premium }

class PlanEntity {
  final PlanType type;
  final String name;
  final String monthlyPrice;
  final String yearlyPrice;
  final String badge;
  final List<String> features;
  final List<String> disabledFeatures;
  final int dailyDecodeLimit;
  final int recentSearchLimit;

  const PlanEntity({
    required this.type,
    required this.name,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.badge,
    required this.features,
    this.disabledFeatures = const [],
    required this.dailyDecodeLimit,
    required this.recentSearchLimit,
  });

  static const List<PlanEntity> plans = [
    PlanEntity(
      type: PlanType.basic,
      name: 'Basic',
      monthlyPrice: 'Free',
      yearlyPrice: 'Free',
      badge: 'FREE',
      features: [
        '3 decodes/day',
        '5 recent searches',
        'Basic vehicle info only',
      ],
      disabledFeatures: [
        'Safety ratings',
        'Market value data',
        'PDF export',
        'Ad-free experience',
      ],
      dailyDecodeLimit: 3,
      recentSearchLimit: 5,
    ),
    PlanEntity(
      type: PlanType.standard,
      name: 'Standard',
      monthlyPrice: '\$4.99/mo',
      yearlyPrice: '\$2.99/mo',
      badge: 'MOST POPULAR',
      features: [
        '20 decodes/day',
        '20 recent searches',
        'Full specifications',
        'Safety ratings',
        'Ad-free experience',
      ],
      disabledFeatures: [
        'Market value data',
        'PDF export',
        'Priority support',
      ],
      dailyDecodeLimit: 20,
      recentSearchLimit: 20,
    ),
    PlanEntity(
      type: PlanType.premium,
      name: 'Premium',
      monthlyPrice: '\$9.99/mo',
      yearlyPrice: '\$6.99/mo',
      badge: 'BEST VALUE',
      features: [
        'Unlimited decodes',
        'Unlimited history',
        'All features',
        'Market value data',
        'PDF export',
        'Priority support',
      ],
      dailyDecodeLimit: 999,
      recentSearchLimit: 999,
    ),
  ];

  static PlanEntity getPlan(PlanType type) {
    return plans.firstWhere((p) => p.type == type);
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/features/subscription/presentation/controllers/subscription_controller.dart';
import 'package:global_vin/features/subscription/domain/entities/plan_entity.dart';
import 'package:global_vin/routes/app_routes.dart';
import '../../domain/entities/vin_entity.dart';

class VinResultPage extends StatelessWidget {
  const VinResultPage({super.key});

  String _countryFlag(String country) {
    final map = {
      'United States': '🇺🇸',
      'Japan': '🇯🇵',
      'Germany': '🇩🇪',
      'Canada': '🇨🇦',
      'South Korea': '🇰🇷',
      'United Kingdom': '🇬🇧',
      'Italy': '🇮🇹',
      'France': '🇫🇷',
      'Sweden': '🇸🇪',
    };
    return map[country] ?? '🌍';
  }

  @override
  Widget build(BuildContext context) {
    final VinEntity vehicle = Get.arguments as VinEntity;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: AppColors.background,
              expandedHeight: 200,
              pinned: true,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_rounded),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(56, 8, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.vin,
                          style: AppTypography.vinSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${vehicle.year} ${vehicle.make}',
                          style: AppTypography.heading2,
                        ),
                        Text(
                          vehicle.model,
                          style: AppTypography.heading1
                              .copyWith(color: AppColors.primary),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              _countryFlag(vehicle.country),
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              vehicle.country,
                              style: AppTypography.body,
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                vehicle.vehicleType,
                                style: AppTypography.caption
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: const TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(text: AppStrings.overview),
                  Tab(text: 'Specs'),
                  Tab(text: AppStrings.equipment),
                  Tab(text: AppStrings.safety),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _OverviewTab(vehicle: vehicle),
              _SpecificationsTab(vehicle: vehicle),
              _EquipmentTab(vehicle: vehicle),
              _SafetyTab(vehicle: vehicle),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.divider, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.favorite_border_rounded,
                  label: 'Save',
                  onTap: () {
                    Get.snackbar(
                      'Saved!',
                      'Vehicle added to favorites',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.surfaceLight,
                      colorText: AppColors.textPrimary,
                      margin: const EdgeInsets.all(16),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  icon: Icons.share_rounded,
                  label: 'Share',
                  onTap: () {
                    Get.snackbar(
                      'Share',
                      'Share coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.surfaceLight,
                      colorText: AppColors.textPrimary,
                      margin: const EdgeInsets.all(16),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(label, style: AppTypography.bodyBold),
          ],
        ),
      ),
    );
  }
}

// ======== Tab 1: Overview ========
class _OverviewTab extends StatelessWidget {
  final VinEntity vehicle;
  const _OverviewTab({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Vehicle image placeholder
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  AppColors.primaryDark.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _vehicleIcon(vehicle.bodyType),
                  size: 64,
                  color: AppColors.primary.withOpacity(0.6),
                ),
                const SizedBox(height: 8),
                Text(
                  '${vehicle.year} ${vehicle.make} ${vehicle.model}',
                  style: AppTypography.body.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms),
          const SizedBox(height: 20),
          // Info grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              _InfoCard(
                  icon: Icons.car_rental, label: 'Body Type', value: vehicle.bodyType),
              _InfoCard(
                  icon: Icons.local_gas_station, label: 'Fuel Type', value: vehicle.fuelType),
              _InfoCard(
                  icon: Icons.settings, label: 'Drive Type', value: vehicle.driveType),
              _InfoCard(
                  icon: Icons.swap_horiz, label: 'Transmission', value: vehicle.transmission),
              _InfoCard(
                  icon: Icons.door_front_door_outlined, label: 'Doors', value: vehicle.doors),
              _InfoCard(
                  icon: Icons.event_seat, label: 'Seats', value: vehicle.seats),
              _InfoCard(
                  icon: Icons.palette, label: 'Color', value: vehicle.color),
              _InfoCard(
                  icon: Icons.category, label: 'Vehicle Type', value: vehicle.vehicleType),
            ],
          ),
        ],
      ),
    );
  }

  IconData _vehicleIcon(String bodyType) {
    switch (bodyType.toLowerCase()) {
      case 'suv':
        return Icons.directions_car_filled;
      case 'truck':
        return Icons.local_shipping;
      case 'coupe':
        return Icons.sports_motorsports;
      default:
        return Icons.directions_car;
    }
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.divider.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTypography.caption),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTypography.bodyBold.copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======== Tab 2: Specifications ========
class _SpecificationsTab extends StatelessWidget {
  final VinEntity vehicle;
  const _SpecificationsTab({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SpecSection(title: 'Engine', specs: [
            _SpecRow('Engine', vehicle.engine),
            _SpecRow('Horsepower', vehicle.engineHp),
            _SpecRow('Cylinders', vehicle.cylinders),
          ]),
          _SpecSection(title: 'Dimensions', specs: [
            _SpecRow('Doors', vehicle.doors),
            _SpecRow('Seats', vehicle.seats),
            _SpecRow('Body Class', vehicle.bodyType),
          ]),
          _SpecSection(title: 'Drivetrain', specs: [
            _SpecRow('Transmission', vehicle.transmission),
            _SpecRow('Drive Type', vehicle.driveType),
            _SpecRow('Fuel Type', vehicle.fuelType),
          ]),
          _SpecSection(title: 'Identity', specs: [
            _SpecRow('Make', vehicle.make),
            _SpecRow('Model', vehicle.model),
            _SpecRow('Year', vehicle.year),
            _SpecRow('Manufacturer', vehicle.manufacturer),
            _SpecRow('Plant City', vehicle.plantCity),
          ]),
        ],
      ),
    );
  }
}

class _SpecSection extends StatelessWidget {
  final String title;
  final List<Widget> specs;

  const _SpecSection({required this.title, required this.specs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.heading4),
        const SizedBox(height: 12),
        ...specs,
        const SizedBox(height: 20),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;

  const _SpecRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.divider.withOpacity(0.5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.body),
          Flexible(
            child: Text(
              value,
              style: AppTypography.specValue,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// ======== Tab 3: Equipment ========
class _EquipmentTab extends StatelessWidget {
  final VinEntity vehicle;
  const _EquipmentTab({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: vehicle.equipment.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.divider.withOpacity(0.3)),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  vehicle.equipment[index],
                  style: AppTypography.body.copyWith(color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(
              delay: Duration(milliseconds: index * 50),
              duration: 300.ms,
            )
            .slideX(begin: 0.05, end: 0);
      },
    );
  }
}

// ======== Tab 4: Safety ========
class _SafetyTab extends StatelessWidget {
  final VinEntity vehicle;
  const _SafetyTab({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final subController = Get.find<SubscriptionController>();

    return Obx(() {
      if (subController.currentPlan.value == PlanType.basic) {
        return _LockedContent();
      }
      return _UnlockedSafety(vehicle: vehicle);
    });
  }
}

class _LockedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred content
        Opacity(
          opacity: 0.3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: List.generate(
                6,
                (_) => Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
        // Lock overlay
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppColors.surface.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock_rounded,
                        size: 48, color: AppColors.textSecondary),
                    const SizedBox(height: 16),
                    Text('Safety Data Locked',
                        style: AppTypography.heading4),
                    const SizedBox(height: 8),
                    Text(
                      'Upgrade to Standard or Premium\nto access safety ratings',
                      style: AppTypography.body,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 44,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onPressed: () => Get.toNamed(AppRoutes.subscription),
                          child: Text('Upgrade to Standard',
                              style: AppTypography.bodyBold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UnlockedSafety extends StatelessWidget {
  final VinEntity vehicle;
  const _UnlockedSafety({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Safety rating badge
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.success.withOpacity(0.15),
                  AppColors.success.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.success.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final stars =
                        int.tryParse(vehicle.safetyRating.split('-').first) ?? 5;
                    return Icon(
                      i < stars ? Icons.star_rounded : Icons.star_border_rounded,
                      color: AppColors.gold,
                      size: 32,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  vehicle.safetyRating,
                  style: AppTypography.heading4
                      .copyWith(color: AppColors.success),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 400.ms).scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.0, 1.0),
              ),
          const SizedBox(height: 24),
          Text('Safety Features', style: AppTypography.heading4),
          const SizedBox(height: 12),
          ...vehicle.safetyFeatures.asMap().entries.map(
                (entry) => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(color: AppColors.divider.withOpacity(0.3)),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shield,
                          color: AppColors.success, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: AppTypography.body
                              .copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: entry.key * 50),
                      duration: 300.ms,
                    )
                    .slideX(begin: 0.05, end: 0),
              ),
        ],
      ),
    );
  }
}

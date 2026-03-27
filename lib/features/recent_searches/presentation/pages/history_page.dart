import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_strings.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/features/subscription/presentation/controllers/subscription_controller.dart';
import 'package:global_vin/features/subscription/domain/entities/plan_entity.dart';
import 'package:global_vin/features/vin_decoder/data/mock/mock_vin_data.dart';
import 'package:global_vin/routes/app_routes.dart';
import '../controllers/recent_search_controller.dart';

class HistoryPage extends GetView<RecentSearchController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.searchHistory, style: AppTypography.heading3),
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Plan limit banner
          Obx(() {
            final subController = Get.find<SubscriptionController>();
            if (subController.currentPlan.value == PlanType.basic) {
              final count = controller.searches.length;
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppColors.warning.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: AppColors.warning, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '$count/5 searches used — Upgrade for more',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.warning),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.subscription),
                      child: Text(
                        'Upgrade',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          // List
          Expanded(
            child: Obx(() {
              final searches = controller.searches;

              if (searches.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 64,
                        color: AppColors.textSecondary.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(AppStrings.emptyHistory,
                          style: AppTypography.heading4),
                      const SizedBox(height: 8),
                      Text(
                        'Start decoding VINs to build your history',
                        style: AppTypography.body,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: searches.length,
                itemBuilder: (context, index) {
                  final search = searches[index];
                  return Dismissible(
                    key: Key(search.vin + search.searchedAt.toIso8601String()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: AppColors.error.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.delete_outline,
                          color: AppColors.error),
                    ),
                    confirmDismiss: (_) async {
                      return await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: AppColors.surface,
                          title: Text('Delete Search',
                              style: AppTypography.heading4),
                          content: Text(
                            'Remove this search from history?',
                            style: AppTypography.body,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Delete',
                                  style: TextStyle(color: AppColors.error)),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (_) => controller.removeSearch(search.vin),
                    child: GestureDetector(
                      onTap: () {
                        final vinData = MockVinData.getByVin(search.vin);
                        Get.toNamed(AppRoutes.vinResult, arguments: vinData);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: AppColors.divider.withOpacity(0.5)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.directions_car_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${search.make} ${search.model}',
                                    style: AppTypography.bodyBold,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    search.vin,
                                    style: AppTypography.vinSmall,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    search.year,
                                    style: AppTypography.caption
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  search.timeAgo,
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textSecondary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
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
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.searches.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      backgroundColor: AppColors.surface,
                      title: Text(AppStrings.clearAll,
                          style: AppTypography.heading4),
                      content: Text(
                        'This will remove all your search history.',
                        style: AppTypography.body,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Clear All',
                              style: TextStyle(color: AppColors.error)),
                        ),
                      ],
                    ),
                  );
                  if (confirmed == true) {
                    controller.clearAll();
                  }
                },
                backgroundColor: AppColors.error,
                icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white),
                label: Text(AppStrings.clearAll,
                    style: AppTypography.bodySmall
                        .copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

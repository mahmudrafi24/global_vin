import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/constants/app_typography.dart';
import 'package:global_vin/features/vin_decoder/data/mock/mock_vin_data.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/routes/app_routes.dart';
import '../controllers/recent_search_controller.dart';

class RecentSearchList extends GetView<RecentSearchController> {
  const RecentSearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final searches = controller.searches;

      if (searches.isEmpty) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.divider,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 32.w,
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
              SizedBox(height: 8.h),
              Text(
                'No recent searches yet',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        );
      }

      return SizedBox(
        height: 110.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: searches.length > 5 ? 5 : searches.length,
          separatorBuilder: (_, __) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final search = searches[index];
            return GestureDetector(
              onTap: () {
                final vinData = MockVinData.getByVin(search.vin);
                Get.toNamed(AppRoutes.vinResult, arguments: vinData);
              },
              child: Container(
                width: 200.w,
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.divider.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${search.make} ${search.model}',
                            style: AppTypography.bodyBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            search.year,
                            style: AppTypography.caption
                                .copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      search.vin.length > 14
                          ? '${search.vin.substring(0, 14)}...'
                          : search.vin,
                      style: AppTypography.vinSmall,
                    ),
                    Text(search.timeAgo, style: AppTypography.caption),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

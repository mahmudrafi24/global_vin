import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:global_vin/core/widgets/common_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:global_vin/core/constants/app_colors.dart';
import 'package:global_vin/core/utils/app_settings.dart';
import 'package:global_vin/core/widgets/core_screen_utils.dart';
import 'package:global_vin/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigate();
    });
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    final settings = Get.find<AppSettings>();
    if (settings.onboardingDone) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    CoreScreenUtils.init(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Car icon with gradient
            Container(
                    width: 100.w,
                    height: 100.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: .3),
                          blurRadius: 30.r,
                          spreadRadius: 5.r,
                        ),
                      ],
                    ),
                    child: CommonImage(
                      src: "assets/images/GLOVIN logo.png",
                      size: 50,
                      imageColor: Colors.white,
                    ))
                .animate()
                .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1.0, 1.0),
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(duration: 400.ms),
            SizedBox(height: 24.h),
            // App name with gradient text
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppColors.primaryGradient.createShader(bounds),
              child: Text(
                'VinDecode',
                style: GoogleFonts.inter(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 300.ms, duration: 500.ms)
                .slideY(begin: 0.3, end: 0, duration: 500.ms),
            SizedBox(height: 8.h),
            Text(
              'Decode Any Vehicle',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                letterSpacing: 2,
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 500.ms),
          ],
        ),
      ),
    );
  }
}

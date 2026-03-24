import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_skin_routine/presentation/providers/profile_provider.dart';
import 'package:my_skin_routine/presentation/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    // Check if onboarding is complete
    final profile = await ref.read(profileProvider.future);

    if (!mounted) return;

    if (profile?.onboardingComplete ?? false) {
      context.go('/home');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.seedColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation: fade in + scale up with spring + slight rotation
            Image.asset(
              'assets/images/logo.png',
              width: 120,
              height: 120,
            )
                .animate()
                .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                .scale(
                  begin: const Offset(0.3, 0.3),
                  end: const Offset(1.0, 1.0),
                  duration: 800.ms,
                  curve: Curves.easeOutBack,
                )
                .shimmer(
                  delay: 800.ms,
                  duration: 1000.ms,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
            const SizedBox(height: 32),
            // App name animation: fade in + slide up after logo
            Text(
              'My Skin Routine',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 600.ms)
                .slideY(
                  begin: 0.3,
                  delay: 500.ms,
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              'Your skincare companion',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
            )
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .slideY(
                  begin: 0.3,
                  delay: 800.ms,
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      ),
    );
  }
}

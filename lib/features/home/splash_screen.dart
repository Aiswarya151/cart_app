import 'package:cart_app/core/theme/app_colors.dart';
import 'package:cart_app/core/utils/storage_service.dart';
import 'package:cart_app/features/authentication/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    
    super.initState();
    _navigateAfterDelay();
    
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3)); // Optional delay
    await _checkUserToken();
  }

  // Check User token already exists
  Future<void> _checkUserToken() async {
    UserModel? user = await StorageService().getUserData();
    if (user != null) {
      if (user.token != null) {
        // Navigate to counter screen
        if (mounted) {
          context.goNamed('products');
        }
      }
    } else {
      // Navigate to login screen
      if (mounted) {
        context.goNamed('login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Lottie.asset(
          'assets/animations/cart_loading.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

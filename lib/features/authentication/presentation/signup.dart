import 'package:cart_app/core/router/router.dart';
import 'package:cart_app/core/shared_widgets/custom_textfield.dart';
import 'package:cart_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100), // Adjust for spacing
            const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 40), // Space below title

            // Username Field
            CustomTextField(hintText: "Username"),
            const SizedBox(height: 16), // Spacing

            // Email Field
            CustomTextField(hintText: "Your Email"),
            const SizedBox(height: 16), // Spacing

            // Password Field
            CustomTextField(
              obscureText: !isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),

            const SizedBox(height: 24), // Spacing

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle sign-up logic
                },
                child: const Text(
                  "Continue",
                  // style: TextStyle(
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.white,
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2A2A2A),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    appRouter.goNamed('login');
                    // Navigate to login page
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 14, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

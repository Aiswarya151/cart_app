import 'dart:developer';

import 'package:cart_app/core/utils/storage_service.dart';
import 'package:cart_app/features/authentication/data/model/user_model.dart';
import 'package:cart_app/features/authentication/data/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
 
  UserModel? _user;
  UserModel? get user => _user;

  // Register User
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await AuthServices().signUp(
        username: username,
        email: email,
        password: password,
      );
      if (response.statusCode == 201) {
        _user = UserModel.fromJson(response.data);
        // Store user data locally
        await StorageService.saveTokenAndUserData(_user!);
        log("User Registration Completed");
        // ignore: use_build_context_synchronously
        context.goNamed('products');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Login User
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await AuthServices().login(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        log(" User Logged In Successfully");

        _user = UserModel.fromJson(response.data);

        // Store user data locally
        await StorageService.saveTokenAndUserData(_user!);

        // Retrieve stored user data to verify it is saved
        UserModel? storedUser = await StorageService().getUserData();
        // ignore: use_build_context_synchronously
        context.goNamed('products');

        if (storedUser != null) {
          log(" Stored User Data Retrieved:");
          log(" Username: ${storedUser.user?.username ?? ""}");
          log(" Email: ${storedUser.user?.email ?? ""}");
          //log(" Token: ${storedUser.token}");
        } else {
          log(" No User Data Found in Storage!");
        }
      }
    } catch (e) {
      log(" Error: $e");
    }
  }

  // Logout User
  Future<void> logout(BuildContext context) async {
    try {
      await StorageService.clearUserData(); // Clear stored user data
      _user = null; // Reset user state
      notifyListeners();
      log("User Logged Out Successfully");
      // ignore: use_build_context_synchronously
      context.goNamed('login'); // Navigate to login screen
    } catch (e) {
      log("Error during logout: $e");
    }
  }
}
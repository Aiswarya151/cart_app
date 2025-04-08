import 'dart:developer';

import 'package:cart_app/core/shared_widgets/custom_snackbar.dart';
import 'package:cart_app/core/utils/storage_service.dart';
import 'package:cart_app/features/authentication/data/model/user_model.dart';
import 'package:cart_app/features/authentication/data/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  bool _isloading = false;
  bool get isloading => _isloading;

  // Register User
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isloading = true;
    notifyListeners(); // so loading button updates
    try {
      final response = await AuthServices().signUp(
        username: username,
        email: email,
        password: password,
      );
      if (response.statusCode == 201) {
        _user = UserModel.fromJson(response.data);

        await StorageService.saveTokenAndUserData(_user!);
        log("User Registration Completed");

        
        customSnackbar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "User Registration Completed Successfully",
          type: SnackbarType.success,
        );

        // ignore: use_build_context_synchronously
        context.goNamed('products');
      } else {
        
        customSnackbar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Registration failed. Please try again.",
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      log(e.toString());

      
      customSnackbar(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Something went wrong",
        type: SnackbarType.error,
      );
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // Login User
  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      final response = await AuthServices().login(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        _user = UserModel.fromJson(response.data);
        await StorageService.saveTokenAndUserData(_user!);

        UserModel? storedUser = await StorageService().getUserData();

        
        customSnackbar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "User Logged In Successfully",
          type: SnackbarType.success,
        );

        // ignore: use_build_context_synchronously
        context.goNamed('products');

        if (storedUser != null) {
          log("Username: ${storedUser.user?.username ?? ""}");
          log("Email: ${storedUser.user?.email ?? ""}");
        } else {
          log("No User Data Found in Storage!");
        }
      } else {
        
        customSnackbar(
          // ignore: use_build_context_synchronously
          context: context,
          message: "Login failed. Please check your credentials.",
          type: SnackbarType.error,
        );
      }
    } catch (e) {
      log("Login Error: $e");

      
      customSnackbar(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Something went wrong",
        type: SnackbarType.error,
      );
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }

  // Logout User
  Future<void> logout(BuildContext context) async {
    _isloading = true;
    notifyListeners();
    try {
      await StorageService.clearUserData();
      _user = null;
      log("User Logged Out Successfully");

     
      customSnackbar(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Logged out successfully",
        type: SnackbarType.success,
      );

      // ignore: use_build_context_synchronously
      context.goNamed('login');
    } catch (e) {
      log("Error during logout: $e");

      // ignore: use_build_context_synchronously
      customSnackbar(
        // ignore: use_build_context_synchronously
        context: context,
        message: "Logout failed: ${e.toString()}",
        type: SnackbarType.error,
      );
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}

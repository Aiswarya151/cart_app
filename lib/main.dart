import 'package:cart_app/core/router/router.dart';
import 'package:cart_app/core/theme/theme.dart';
import 'package:cart_app/features/authentication/viewmodel/auth_provider.dart';
import 'package:cart_app/features/cart/viewmodel/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
         ChangeNotifierProvider(create: (_) => AuthProvider()),
         ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(
      
        ),));
     
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
     
    );
  }
}

 
import 'package:cart_app/features/authentication/presentation/login.dart';
import 'package:cart_app/features/authentication/presentation/signup.dart';
import 'package:cart_app/features/cart/presentation/screens/my_cart.dart';
import 'package:cart_app/features/cart/presentation/screens/products.dart';
import 'package:cart_app/features/home/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter=GoRouter(initialLocation:'/',
routes: [
   GoRoute(path: '/',name: 'home',builder: (context, state) => HomeScreen(),),
  GoRoute(path: '/products',name: 'products',builder: (context, state) => ProductsScreen(),),
  GoRoute(path: '/login',name: 'login',builder: (context, state) => LoginScreen(),),
   GoRoute(path: '/signup',name: 'signup',builder: (context, state) => SignUpScreen(),),
   GoRoute(path: '/cart',name: 'cart',builder: (context, state) => CartScreen(),)
] );
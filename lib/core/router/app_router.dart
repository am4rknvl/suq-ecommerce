import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/main_navigation_screen.dart';
import '../../features/products/presentation/screens/product_details_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/seller/presentation/screens/seller_dashboard_screen.dart';
import '../../features/seller/presentation/screens/add_product_screen.dart';
import '../../features/seller/presentation/screens/manage_orders_screen.dart';
import '../services/storage_service.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Splash and Onboarding
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      
      // Authentication
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/otp-verification',
        name: 'otp-verification',
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return OtpVerificationScreen(phoneNumber: phoneNumber);
        },
      ),
      
      // Main App
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      
      // Products
      GoRoute(
        path: '/product/:productId',
        name: 'product-details',
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          return ProductDetailsScreen(productId: productId);
        },
      ),
      
      // Cart and Checkout
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      
      // Profile
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      
      // Seller Features
      GoRoute(
        path: '/seller-dashboard',
        name: 'seller-dashboard',
        builder: (context, state) => const SellerDashboardScreen(),
      ),
      GoRoute(
        path: '/add-product',
        name: 'add-product',
        builder: (context, state) => const AddProductScreen(),
      ),
      GoRoute(
        path: '/manage-orders',
        name: 'manage-orders',
        builder: (context, state) => const ManageOrdersScreen(),
      ),
    ],
    
    // Redirect logic
    redirect: (context, state) {
      final isLoggedIn = StorageService.isLoggedIn;
      final isOnboardingCompleted = StorageService.isOnboardingCompleted();
      final currentPath = state.matchedLocation;
      
      // If not logged in and trying to access protected routes
      if (!isLoggedIn && _isProtectedRoute(currentPath)) {
        if (!isOnboardingCompleted && currentPath != '/onboarding') {
          return '/onboarding';
        }
        return '/login';
      }
      
      // If logged in and trying to access auth routes
      if (isLoggedIn && _isAuthRoute(currentPath)) {
        return '/home';
      }
      
      // If onboarding not completed and logged in
      if (isLoggedIn && !isOnboardingCompleted && currentPath != '/onboarding') {
        return '/onboarding';
      }
      
      return null; // No redirect needed
    },
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

bool _isProtectedRoute(String path) {
  const protectedRoutes = [
    '/home',
    '/profile',
    '/cart',
    '/checkout',
    '/seller-dashboard',
    '/add-product',
    '/manage-orders',
  ];
  
  return protectedRoutes.any((route) => path.startsWith(route));
}

bool _isAuthRoute(String path) {
  const authRoutes = [
    '/login',
    '/signup',
    '/otp-verification',
  ];
  
  return authRoutes.contains(path);
}

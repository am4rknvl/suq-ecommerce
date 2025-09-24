import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/providers/locale_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/gamification_stats.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userRole = StorageService.getUserRole();
    final isSeller = userRole == 'seller' || userRole == 'both';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            title: const Text('Profile'),
            actions: [
              IconButton(
                onPressed: () {
                  // TODO: Navigate to settings
                },
                icon: const Icon(Icons.settings),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile Header
                const ProfileHeader()
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 600))
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                const SizedBox(height: 16),

                // Gamification Stats
                const GamificationStats()
                    .animate(delay: const Duration(milliseconds: 200))
                    .fadeIn(duration: const Duration(milliseconds: 600))
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                const SizedBox(height: 24),

                // Menu Items
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Account Section
                      _buildSectionTitle('Account'),
                      const SizedBox(height: 8),
                      
                      ProfileMenuItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        subtitle: 'Update your personal information',
                        onTap: () {
                          // TODO: Navigate to edit profile
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 400))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      ProfileMenuItem(
                        icon: Icons.shopping_bag_outlined,
                        title: 'My Orders',
                        subtitle: 'Track your orders and history',
                        onTap: () {
                          // TODO: Navigate to orders
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 500))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      ProfileMenuItem(
                        icon: Icons.favorite_outline,
                        title: 'Wishlist',
                        subtitle: 'Your saved products',
                        onTap: () {
                          // TODO: Navigate to wishlist
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 600))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      const SizedBox(height: 24),

                      // Seller Section
                      if (isSeller) ...[
                        _buildSectionTitle('Seller'),
                        const SizedBox(height: 8),
                        
                        ProfileMenuItem(
                          icon: Icons.store_outlined,
                          title: 'Seller Dashboard',
                          subtitle: 'Manage your shop and products',
                          onTap: () {
                            context.pushNamed('seller-dashboard');
                          },
                        )
                            .animate(delay: const Duration(milliseconds: 700))
                            .fadeIn(duration: const Duration(milliseconds: 400))
                            .slideX(begin: -0.2, curve: Curves.easeOut),

                        ProfileMenuItem(
                          icon: Icons.inventory_outlined,
                          title: 'My Products',
                          subtitle: 'Manage your product listings',
                          onTap: () {
                            // TODO: Navigate to seller products
                          },
                        )
                            .animate(delay: const Duration(milliseconds: 800))
                            .fadeIn(duration: const Duration(milliseconds: 400))
                            .slideX(begin: -0.2, curve: Curves.easeOut),

                        ProfileMenuItem(
                          icon: Icons.analytics_outlined,
                          title: 'Sales Analytics',
                          subtitle: 'View your sales performance',
                          onTap: () {
                            // TODO: Navigate to analytics
                          },
                        )
                            .animate(delay: const Duration(milliseconds: 900))
                            .fadeIn(duration: const Duration(milliseconds: 400))
                            .slideX(begin: -0.2, curve: Curves.easeOut),

                        const SizedBox(height: 24),
                      ] else ...[
                        ProfileMenuItem(
                          icon: Icons.store,
                          title: 'Become a Seller',
                          subtitle: 'Start selling on Ethiopian SUQ',
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryGreen,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'NEW',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          onTap: () {
                            context.pushNamed('seller-dashboard');
                          },
                        )
                            .animate(delay: const Duration(milliseconds: 700))
                            .fadeIn(duration: const Duration(milliseconds: 400))
                            .slideX(begin: -0.2, curve: Curves.easeOut),

                        const SizedBox(height: 24),
                      ],

                      // Gamification Section
                      _buildSectionTitle('Achievements'),
                      const SizedBox(height: 8),
                      
                      ProfileMenuItem(
                        icon: Icons.military_tech,
                        title: 'My Badges',
                        subtitle: 'View all your earned badges',
                        onTap: () {
                          // TODO: Navigate to badges
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1000))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      ProfileMenuItem(
                        icon: Icons.leaderboard,
                        title: 'Leaderboard',
                        subtitle: 'See how you rank against others',
                        onTap: () {
                          // TODO: Navigate to leaderboard
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1100))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      const SizedBox(height: 24),

                      // Settings Section
                      _buildSectionTitle('Settings'),
                      const SizedBox(height: 8),
                      
                      ProfileMenuItem(
                        icon: Icons.dark_mode_outlined,
                        title: 'Dark Mode',
                        subtitle: 'Toggle dark/light theme',
                        trailing: Switch(
                          value: ref.watch(themeModeProvider) == ThemeMode.dark,
                          onChanged: (value) {
                            ref.read(themeModeProvider.notifier).toggleTheme();
                          },
                          activeColor: AppTheme.primaryGreen,
                        ),
                        onTap: () {
                          ref.read(themeModeProvider.notifier).toggleTheme();
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1200))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      ProfileMenuItem(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: ref.watch(localeProvider).languageCode == 'en' 
                            ? 'English' 
                            : 'አማርኛ',
                        trailing: Switch(
                          value: ref.watch(localeProvider).languageCode == 'am',
                          onChanged: (value) {
                            ref.read(localeProvider.notifier).toggleLocale();
                          },
                          activeColor: AppTheme.primaryGreen,
                        ),
                        onTap: () {
                          ref.read(localeProvider.notifier).toggleLocale();
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1300))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () {
                          // TODO: Navigate to notification settings
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1400))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      const SizedBox(height: 24),

                      // Support Section
                      _buildSectionTitle('Support'),
                      const SizedBox(height: 8),
                      
                      ProfileMenuItem(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        subtitle: 'Get help and contact support',
                        onTap: () {
                          // TODO: Navigate to help
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1500))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      ProfileMenuItem(
                        icon: Icons.info_outline,
                        title: 'About',
                        subtitle: 'App version and information',
                        onTap: () {
                          _showAboutDialog();
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1600))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      const SizedBox(height: 24),

                      // Logout
                      ProfileMenuItem(
                        icon: Icons.logout,
                        title: 'Logout',
                        subtitle: 'Sign out of your account',
                        titleColor: AppTheme.error,
                        onTap: () {
                          _showLogoutDialog();
                        },
                      )
                          .animate(delay: const Duration(milliseconds: 1700))
                          .fadeIn(duration: const Duration(milliseconds: 400))
                          .slideX(begin: -0.2, curve: Curves.easeOut),

                      const SizedBox(height: 100), // Bottom padding
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.mediumGrey,
            ),
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Ethiopian SUQ',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.shopping_bag,
          color: Colors.white,
          size: 30,
        ),
      ),
      children: [
        const Text(
          'Ethiopian SUQ is your go-to marketplace for authentic Ethiopian products. '
          'Support local businesses and discover amazing products from across Ethiopia.',
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Clear user data
              await StorageService.clearAuthToken();
              await StorageService.clearUserData();
              
              if (mounted) {
                Navigator.of(context).pop();
                context.go('/login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

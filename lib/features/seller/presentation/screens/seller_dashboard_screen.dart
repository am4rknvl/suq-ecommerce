import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/suq_colors.dart';
import '../../../../core/services/storage_service.dart';
import '../widgets/seller_stats_card.dart';
import '../widgets/quick_seller_actions.dart';
import '../widgets/recent_orders_section.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  bool _isSellerModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkSellerMode();
  }

  void _checkSellerMode() {
    final userRole = StorageService.getUserRole();
    setState(() {
      _isSellerModeEnabled = userRole == 'seller' || userRole == 'both';
    });
  }

  Future<void> _enableSellerMode() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.store,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(width: 8),
            const Text('Enable Seller Mode'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Ethiopian SUQ Seller Program!',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const Text(
              'By enabling seller mode, you can:',
            ),
            const SizedBox(height: 8),
            _BenefitItem(
              icon: Icons.inventory,
              text: 'List and manage products',
            ),
            _BenefitItem(
              icon: Icons.analytics,
              text: 'Track sales and analytics',
            ),
            _BenefitItem(
              icon: Icons.people,
              text: 'Reach thousands of customers',
            ),
            _BenefitItem(
              icon: Icons.stars,
              text: 'Earn seller badges and XP',
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.xpBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.stars,
                    color: AppTheme.xpBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You\'ll earn 50 XP for becoming a seller!',
                      style: TextStyle(
                        color: AppTheme.xpBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Enable Seller Mode'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Enable seller mode
      await StorageService.saveUserRole('both');

      // Award XP for becoming a seller
      final currentXP = StorageService.getUserXP();
      await StorageService.saveUserXP(currentXP + 50);

      // Add first seller badge
      await StorageService.addBadge('new_seller');

      setState(() {
        _isSellerModeEnabled = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.celebration, color: Colors.white),
                const SizedBox(width: 8),
                const Text('Welcome to Ethiopian SUQ Sellers! +50 XP'),
              ],
            ),
            backgroundColor: AppTheme.success,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSellerModeEnabled) {
      return _buildEnableSellerMode();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Dashboard'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [SuqColors.secondary, Color(0xFF1B5E20)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome, Seller!',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Manage your shop and grow your business',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.store,
                    size: 40,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, curve: Curves.easeOut),

            const SizedBox(height: 24),

            // Seller Stats
            const SellerStatsCard()
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, curve: Curves.easeOut),

            const SizedBox(height: 24),

            // Quick Actions
            const QuickSellerActions()
                .animate(delay: const Duration(milliseconds: 400))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, curve: Curves.easeOut),

            const SizedBox(height: 24),

            // Recent Orders
            const RecentOrdersSection()
                .animate(delay: const Duration(milliseconds: 600))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, curve: Curves.easeOut),

            const SizedBox(height: 24),

            // Tips for sellers
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.primaryYellow.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryYellow.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: AppTheme.primaryYellow,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Seller Tips',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryYellow,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _TipItem(text: 'Add high-quality product photos'),
                  _TipItem(text: 'Write detailed product descriptions'),
                  _TipItem(text: 'Respond quickly to customer inquiries'),
                  _TipItem(text: 'Maintain good inventory levels'),
                ],
              ),
            )
                .animate(delay: const Duration(milliseconds: 800))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.2, curve: Curves.easeOut),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed('add-product');
        },
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ).animate(delay: const Duration(milliseconds: 1000)).scale(
            duration: const Duration(milliseconds: 400),
            curve: Curves.elasticOut,
          ),
    );
  }

  Widget _buildEnableSellerMode() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Seller'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.store,
                size: 60,
                color: AppTheme.primaryGreen,
              ),
            ).animate().scale(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                ),
            const SizedBox(height: 32),
            Text(
              'Start Selling on Ethiopian SUQ',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),
            const SizedBox(height: 16),
            Text(
              'Join thousands of Ethiopian entrepreneurs and start your online business today!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.mediumGrey,
                  ),
              textAlign: TextAlign.center,
            )
                .animate(delay: const Duration(milliseconds: 400))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _enableSellerMode,
                icon: const Icon(Icons.store),
                label: const Text('Enable Seller Mode'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
                .animate(delay: const Duration(milliseconds: 600))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BenefitItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: AppTheme.primaryGreen,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;

  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.primaryYellow,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

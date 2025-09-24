import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userRole = StorageService.getUserRole();
    final isSeller = userRole == 'seller' || userRole == 'both';
    
    final actions = [
      QuickAction(
        icon: Icons.qr_code_scanner,
        label: 'Scan QR',
        color: AppTheme.primaryGreen,
        onTap: () {
          // TODO: Implement QR scanner
        },
      ),
      QuickAction(
        icon: Icons.local_offer,
        label: 'Deals',
        color: AppTheme.primaryRed,
        onTap: () {
          // TODO: Navigate to deals
        },
      ),
      QuickAction(
        icon: Icons.history,
        label: 'Orders',
        color: AppTheme.xpBlue,
        onTap: () {
          // TODO: Navigate to orders
        },
      ),
      if (isSeller)
        QuickAction(
          icon: Icons.add_box,
          label: 'Add Product',
          color: AppTheme.primaryYellow,
          onTap: () {
            context.pushNamed('add-product');
          },
        )
      else
        QuickAction(
          icon: Icons.store,
          label: 'Become Seller',
          color: AppTheme.primaryYellow,
          onTap: () {
            _showBecomeSellerDialog(context);
          },
        ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: actions.map((action) {
          final index = actions.indexOf(action);
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index < actions.length - 1 ? 12 : 0,
              ),
              child: _QuickActionCard(
                action: action,
                animationDelay: Duration(milliseconds: index * 100),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showBecomeSellerDialog(BuildContext context) {
    showDialog(
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
            const Text('Become a Seller'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Start selling on Ethiopian SUQ and reach thousands of customers across Ethiopia!',
            ),
            const SizedBox(height: 16),
            const Text(
              'Benefits:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _BenefitItem(
              icon: Icons.trending_up,
              text: 'Reach nationwide customers',
            ),
            _BenefitItem(
              icon: Icons.payment,
              text: 'Multiple payment options',
            ),
            _BenefitItem(
              icon: Icons.support_agent,
              text: 'Seller support & training',
            ),
            _BenefitItem(
              icon: Icons.analytics,
              text: 'Sales analytics & insights',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pushNamed('seller-dashboard');
            },
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final QuickAction action;
  final Duration animationDelay;

  const _QuickActionCard({
    required this.action,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: action.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: action.color.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: action.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                action.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              action.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: action.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate(delay: animationDelay)
        .scale(
          duration: const Duration(milliseconds: 400),
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: const Duration(milliseconds: 300));
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

class QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

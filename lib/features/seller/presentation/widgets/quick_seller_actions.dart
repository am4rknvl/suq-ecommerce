import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class QuickSellerActions extends StatelessWidget {
  const QuickSellerActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      SellerAction(
        icon: Icons.add_box,
        title: 'Add Product',
        subtitle: 'List new item',
        color: AppTheme.primaryGreen,
        onTap: () {
          context.pushNamed('add-product');
        },
      ),
      SellerAction(
        icon: Icons.inventory,
        title: 'Manage Products',
        subtitle: 'Edit listings',
        color: AppTheme.xpBlue,
        onTap: () {
          // TODO: Navigate to manage products
        },
      ),
      SellerAction(
        icon: Icons.receipt_long,
        title: 'Orders',
        subtitle: 'View & manage',
        color: AppTheme.primaryYellow,
        onTap: () {
          context.pushNamed('manage-orders');
        },
      ),
      SellerAction(
        icon: Icons.analytics,
        title: 'Analytics',
        subtitle: 'Sales insights',
        color: AppTheme.primaryRed,
        onTap: () {
          // TODO: Navigate to analytics
        },
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return _ActionCard(
              action: action,
              animationDelay: Duration(milliseconds: index * 100),
            );
          },
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final SellerAction action;
  final Duration animationDelay;

  const _ActionCard({
    required this.action,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action.onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                action.color.withOpacity(0.1),
                action.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const Spacer(),
              Text(
                action.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                action.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.mediumGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: animationDelay)
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}

class SellerAction {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const SellerAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });
}

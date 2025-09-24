import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class SellerStatsCard extends StatelessWidget {
  const SellerStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock seller stats - in real app, get from API
    final stats = [
      {
        'title': 'Products',
        'value': '8',
        'subtitle': '3 active',
        'icon': Icons.inventory,
        'color': AppTheme.xpBlue,
      },
      {
        'title': 'Orders',
        'value': '24',
        'subtitle': 'This month',
        'icon': Icons.shopping_bag,
        'color': AppTheme.primaryGreen,
      },
      {
        'title': 'Revenue',
        'value': '12.5K',
        'subtitle': 'ETB',
        'icon': Icons.attach_money,
        'color': AppTheme.badgeGold,
      },
      {
        'title': 'Rating',
        'value': '4.8',
        'subtitle': '(45 reviews)',
        'icon': Icons.star,
        'color': AppTheme.primaryRed,
      },
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Performance',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: stats.length,
              itemBuilder: (context, index) {
                final stat = stats[index];
                return _StatItem(
                  stat: stat,
                  animationDelay: Duration(milliseconds: index * 100),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final Map<String, dynamic> stat;
  final Duration animationDelay;

  const _StatItem({
    required this.stat,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (stat['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (stat['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                stat['icon'],
                color: stat['color'],
                size: 20,
              ),
              const Spacer(),
              Icon(
                Icons.trending_up,
                color: AppTheme.success,
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            stat['value'],
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: stat['color'],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat['title'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            stat['subtitle'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.mediumGrey,
            ),
          ),
        ],
      ),
    )
        .animate(delay: animationDelay)
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}

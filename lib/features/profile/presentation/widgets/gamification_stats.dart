import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';

class GamificationStats extends StatelessWidget {
  const GamificationStats({super.key});

  @override
  Widget build(BuildContext context) {
    final currentXP = StorageService.getUserXP();
    final userBadges = StorageService.getUserBadges();
    final level = _calculateLevel(currentXP);
    
    // Mock stats - in real app, get from user data
    final stats = [
      {
        'title': 'Level',
        'value': level.toString(),
        'icon': Icons.trending_up,
        'color': AppTheme.xpBlue,
      },
      {
        'title': 'XP Points',
        'value': currentXP.toString(),
        'icon': Icons.stars,
        'color': AppTheme.badgeGold,
      },
      {
        'title': 'Badges',
        'value': userBadges.length.toString(),
        'icon': Icons.military_tech,
        'color': AppTheme.primaryRed,
      },
      {
        'title': 'Orders',
        'value': '12', // TODO: Get from actual data
        'icon': Icons.shopping_bag,
        'color': AppTheme.primaryGreen,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: stats.map((stat) {
          final index = stats.indexOf(stat);
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(
                right: index < stats.length - 1 ? 12 : 0,
              ),
              child: _StatCard(
                stat: stat,
                animationDelay: Duration(milliseconds: index * 100),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  int _calculateLevel(int xp) {
    if (xp < 100) return 1;
    if (xp < 250) return 2;
    if (xp < 500) return 3;
    if (xp < 1000) return 4;
    if (xp < 2000) return 5;
    if (xp < 5000) return 6;
    return 7; // Max level
  }
}

class _StatCard extends StatelessWidget {
  final Map<String, dynamic> stat;
  final Duration animationDelay;

  const _StatCard({
    required this.stat,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (stat['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                stat['icon'],
                color: stat['color'],
                size: 24,
              ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              stat['value'],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: stat['color'],
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              stat['title'],
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.mediumGrey,
                    fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate(delay: animationDelay)
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }
}

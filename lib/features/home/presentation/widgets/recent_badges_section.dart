import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';

class RecentBadgesSection extends StatelessWidget {
  const RecentBadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userBadges = StorageService.getUserBadges();
    
    // Mock recent badges for demo
    final recentBadges = [
      {
        'id': 'first_order',
        'name': 'First Order',
        'description': 'Completed your first order',
        'icon': Icons.shopping_bag,
        'color': AppTheme.badgeGold,
        'isNew': true,
      },
      {
        'id': 'profile_complete',
        'name': 'Profile Complete',
        'description': 'Completed your profile',
        'icon': Icons.person,
        'color': AppTheme.badgeSilver,
        'isNew': false,
      },
      {
        'id': 'early_adopter',
        'name': 'Early Adopter',
        'description': 'Joined Ethiopian SUQ',
        'icon': Icons.star,
        'color': AppTheme.badgeBronze,
        'isNew': false,
      },
    ];

    if (recentBadges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.military_tech,
                color: AppTheme.badgeGold,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Recent Badges',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all badges screen
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: recentBadges.length,
            itemBuilder: (context, index) {
              final badge = recentBadges[index];
              final isUnlocked = userBadges.contains(badge['id']);
              
              return Container(
                width: 100,
                margin: const EdgeInsets.only(right: 12),
                child: Column(
                  children: [
                    // Badge container
                    Stack(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: isUnlocked 
                                ? (badge['color'] as Color).withOpacity(0.1)
                                : Colors.grey.shade200,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isUnlocked 
                                  ? (badge['color'] as Color)
                                  : Colors.grey.shade400,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            badge['icon'] as IconData,
                            size: 32,
                            color: isUnlocked 
                                ? (badge['color'] as Color)
                                : Colors.grey.shade400,
                          ),
                        ),
                        
                        // New badge indicator
                        if (badge['isNew'] == true && isUnlocked)
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryRed,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.fiber_new,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        
                        // Lock overlay for locked badges
                        if (!isUnlocked)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
                    )
                        .animate(delay: Duration(milliseconds: index * 100))
                        .scale(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.elasticOut,
                        )
                        .fadeIn(duration: const Duration(milliseconds: 300)),
                    
                    const SizedBox(height: 8),
                    
                    // Badge name
                    Text(
                      badge['name'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isUnlocked 
                                ? AppTheme.darkGrey
                                : AppTheme.mediumGrey,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                        .animate(delay: Duration(milliseconds: index * 100 + 200))
                        .fadeIn(duration: const Duration(milliseconds: 400))
                        .slideY(begin: 0.3, curve: Curves.easeOut),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

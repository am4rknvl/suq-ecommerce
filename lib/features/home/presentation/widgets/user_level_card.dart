import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/services/storage_service.dart';

class UserLevelCard extends StatelessWidget {
  const UserLevelCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual user data from provider
    final currentXP = StorageService.getUserXP();
    final level = _calculateLevel(currentXP);
    final levelInfo = _getLevelInfo(level);
    final progress = _calculateProgress(currentXP, level);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.xpBlue,
            const Color(0xFF1565C0),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.xpBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Level icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getLevelIcon(level),
                  color: Colors.white,
                  size: 28,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Level info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level $level',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      levelInfo['title']!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
              
              // XP display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.stars,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$currentXP XP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress to Level ${level + 1}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                  ),
                  Text(
                    '${levelInfo['xpToNext']} XP to go',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              )
                  .animate()
                  .scaleX(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut,
                  ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Level perks
          if (levelInfo['perks']!.isNotEmpty) ...[
            Text(
              'Level Perks:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              levelInfo['perks']!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
            ),
          ],
        ],
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

  Map<String, dynamic> _getLevelInfo(int level) {
    final levelThresholds = [0, 100, 250, 500, 1000, 2000, 5000];
    final currentXP = StorageService.getUserXP();
    
    String title = AppConfig.levelTitles[levelThresholds[level - 1]] ?? 'Legend';
    int xpToNext = 0;
    String perks = '';
    
    if (level < 7) {
      xpToNext = levelThresholds[level] - currentXP;
    }
    
    switch (level) {
      case 1:
        perks = 'Welcome bonus, Basic support';
        break;
      case 2:
        perks = 'Free shipping on orders over 500 ETB';
        break;
      case 3:
        perks = '5% discount on selected items';
        break;
      case 4:
        perks = 'Priority customer support, Early access to sales';
        break;
      case 5:
        perks = '10% discount, VIP customer status';
        break;
      case 6:
        perks = 'Exclusive products, Personal shopping assistant';
        break;
      case 7:
        perks = 'Maximum benefits, Legendary status';
        break;
    }
    
    return {
      'title': title,
      'xpToNext': xpToNext,
      'perks': perks,
    };
  }

  double _calculateProgress(int currentXP, int level) {
    final levelThresholds = [0, 100, 250, 500, 1000, 2000, 5000];
    
    if (level >= 7) return 1.0; // Max level
    
    final currentLevelXP = levelThresholds[level - 1];
    final nextLevelXP = levelThresholds[level];
    final progressXP = currentXP - currentLevelXP;
    final totalXPNeeded = nextLevelXP - currentLevelXP;
    
    return (progressXP / totalXPNeeded).clamp(0.0, 1.0);
  }

  IconData _getLevelIcon(int level) {
    switch (level) {
      case 1:
        return Icons.star_border;
      case 2:
        return Icons.star_half;
      case 3:
        return Icons.star;
      case 4:
        return Icons.stars;
      case 5:
        return Icons.diamond_outlined;
      case 6:
        return Icons.diamond;
      case 7:
        return Icons.emoji_events;
      default:
        return Icons.star;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category(
        id: 'electronics',
        name: 'Electronics',
        icon: Icons.phone_android,
        color: AppTheme.xpBlue,
      ),
      Category(
        id: 'fashion',
        name: 'Fashion',
        icon: Icons.checkroom,
        color: AppTheme.primaryRed,
      ),
      Category(
        id: 'home',
        name: 'Home & Garden',
        icon: Icons.home,
        color: AppTheme.primaryGreen,
      ),
      Category(
        id: 'books',
        name: 'Books',
        icon: Icons.menu_book,
        color: AppTheme.primaryYellow,
      ),
      Category(
        id: 'sports',
        name: 'Sports',
        icon: Icons.sports_soccer,
        color: Colors.orange,
      ),
      Category(
        id: 'beauty',
        name: 'Beauty',
        icon: Icons.face_retouching_natural,
        color: Colors.pink,
      ),
      Category(
        id: 'food',
        name: 'Food & Drinks',
        icon: Icons.restaurant,
        color: Colors.brown,
      ),
      Category(
        id: 'automotive',
        name: 'Automotive',
        icon: Icons.directions_car,
        color: Colors.grey,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.category,
                color: AppTheme.primaryGreen,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all categories
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            
            return GestureDetector(
              onTap: () {
                // TODO: Navigate to category products
              },
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: category.color.withOpacity(0.3),
                      ),
                    ),
                    child: Icon(
                      category.icon,
                      color: category.color,
                      size: 28,
                    ),
                  )
                      .animate(delay: Duration(milliseconds: index * 50))
                      .scale(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.elasticOut,
                      )
                      .fadeIn(duration: const Duration(milliseconds: 300)),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                      .animate(delay: Duration(milliseconds: index * 50 + 100))
                      .fadeIn(duration: const Duration(milliseconds: 400))
                      .slideY(begin: 0.3, curve: Curves.easeOut),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

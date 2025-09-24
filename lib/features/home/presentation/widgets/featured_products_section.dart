import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class FeaturedProductsSection extends StatelessWidget {
  const FeaturedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock featured products for demo
    final featuredProducts = [
      FeaturedProduct(
        id: '1',
        name: 'Ethiopian Coffee Beans',
        price: 450.0,
        originalPrice: 500.0,
        imageUrl: 'https://via.placeholder.com/200x200/8BC34A/FFFFFF?text=Coffee',
        sellerName: 'Addis Coffee Co.',
        rating: 4.8,
        reviewsCount: 124,
        isOnSale: true,
      ),
      FeaturedProduct(
        id: '2',
        name: 'Traditional Habesha Dress',
        price: 2500.0,
        originalPrice: null,
        imageUrl: 'https://via.placeholder.com/200x200/E91E63/FFFFFF?text=Dress',
        sellerName: 'Ethiopian Fashion',
        rating: 4.6,
        reviewsCount: 89,
        isOnSale: false,
      ),
      FeaturedProduct(
        id: '3',
        name: 'Smartphone Case',
        price: 120.0,
        originalPrice: 150.0,
        imageUrl: 'https://via.placeholder.com/200x200/2196F3/FFFFFF?text=Phone',
        sellerName: 'Tech Accessories',
        rating: 4.5,
        reviewsCount: 67,
        isOnSale: true,
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
                Icons.star,
                color: AppTheme.badgeGold,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Featured Products',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all featured products
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: featuredProducts.length,
            itemBuilder: (context, index) {
              final product = featuredProducts[index];
              
              return Container(
                width: 180,
                margin: const EdgeInsets.only(right: 16),
                child: _ProductCard(
                  product: product,
                  animationDelay: Duration(milliseconds: index * 100),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final FeaturedProduct product;
  final Duration animationDelay;

  const _ProductCard({
    required this.product,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('product-details', pathParameters: {
          'productId': product.id,
        });
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
                
                // Sale badge
                if (product.isOnSale)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryRed,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'SALE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                
                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            
            // Product details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Seller name
                    Text(
                      product.sellerName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: AppTheme.badgeGold,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toString(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${product.reviewsCount})',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.mediumGrey,
                              ),
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Price
                    Row(
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(0)} ETB',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryGreen,
                              ),
                        ),
                        if (product.originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '${product.originalPrice!.toStringAsFixed(0)} ETB',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: AppTheme.mediumGrey,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate(delay: animationDelay)
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideX(begin: 0.2, curve: Curves.easeOut);
  }
}

class FeaturedProduct {
  final String id;
  final String name;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final String sellerName;
  final double rating;
  final int reviewsCount;
  final bool isOnSale;

  const FeaturedProduct({
    required this.id,
    required this.name,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.sellerName,
    required this.rating,
    required this.reviewsCount,
    required this.isOnSale,
  });
}

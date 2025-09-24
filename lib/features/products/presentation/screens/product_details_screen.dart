import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isAddingToCart = false;

  // Mock product data - in real app, fetch from API
  late Map<String, dynamic> _product;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _loadProduct() {
    // Mock product data
    _product = {
      'id': widget.productId,
      'name': 'Ethiopian Coffee Beans Premium',
      'description': 'Premium quality Ethiopian coffee beans sourced directly from local farmers in the highlands of Ethiopia. Rich, aromatic, and full-bodied flavor that represents the authentic taste of Ethiopian coffee culture.',
      'price': 450.0,
      'originalPrice': 500.0,
      'currency': 'ETB',
      'images': [
        'https://via.placeholder.com/400x400/8BC34A/FFFFFF?text=Coffee+1',
        'https://via.placeholder.com/400x400/4CAF50/FFFFFF?text=Coffee+2',
        'https://via.placeholder.com/400x400/2E7D32/FFFFFF?text=Coffee+3',
      ],
      'sellerName': 'Addis Coffee Co.',
      'sellerShopName': 'Addis Coffee Co.',
      'sellerCity': 'Addis Ababa',
      'sellerRegion': 'Addis Ababa',
      'rating': 4.8,
      'reviewsCount': 124,
      'category': 'Food & Drinks',
      'tags': ['coffee', 'premium', 'ethiopian', 'organic'],
      'stockQuantity': 50,
      'isOnSale': true,
      'weight': 500.0,
      'specifications': {
        'Origin': 'Ethiopian Highlands',
        'Roast Level': 'Medium',
        'Weight': '500g',
        'Processing': 'Washed',
        'Altitude': '1800-2200m',
        'Harvest Season': '2023',
      },
      'reviews': [
        {
          'id': '1',
          'userName': 'Sarah M.',
          'rating': 5.0,
          'comment': 'Amazing coffee! The aroma and taste are exceptional.',
          'date': '2024-01-15',
          'isVerified': true,
        },
        {
          'id': '2',
          'userName': 'John D.',
          'rating': 4.5,
          'comment': 'Great quality, fast delivery. Will order again.',
          'date': '2024-01-10',
          'isVerified': true,
        },
      ],
    };
  }

  void _addToCart() async {
    setState(() {
      _isAddingToCart = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Add to local cart
      final cartItems = StorageService.getCartItems();
      final existingIndex = cartItems.indexWhere(
        (item) => item['productId'] == widget.productId,
      );

      if (existingIndex >= 0) {
        cartItems[existingIndex]['quantity'] += _quantity;
      } else {
        cartItems.add({
          'productId': widget.productId,
          'product': _product,
          'quantity': _quantity,
          'addedAt': DateTime.now().toIso8601String(),
        });
      }

      await StorageService.saveCartItems(cartItems);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text('Added $_quantity item(s) to cart'),
              ],
            ),
            backgroundColor: AppTheme.success,
            action: SnackBarAction(
              label: 'View Cart',
              textColor: Colors.white,
              onPressed: () {
                context.pushNamed('cart');
              },
            ),
          ),
        );

        // Award XP for adding to cart (first time)
        final currentXP = StorageService.getUserXP();
        await StorageService.saveUserXP(currentXP + 5);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add to cart: ${e.toString()}'),
            backgroundColor: AppTheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAddingToCart = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnSale = _product['isOnSale'] ?? false;
    final originalPrice = _product['originalPrice'];
    final discountPercentage = isOnSale && originalPrice != null
        ? ((originalPrice - _product['price']) / originalPrice * 100).round()
        : 0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                  
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO: Implement share
                },
                icon: const Icon(Icons.share),
              ),
            ],
          ),

          // Product Details
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Basic Info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sale badge
                      if (isOnSale)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryRed,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$discountPercentage% OFF',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                            .animate()
                            .scale(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.elasticOut,
                            ),

                      const SizedBox(height: 8),

                      // Product name
                      Text(
                        _product['name'],
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      )
                          .animate()
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .slideY(begin: 0.2, curve: Curves.easeOut),

                      const SizedBox(height: 8),

                      // Seller info
                      Row(
                        children: [
                          Icon(
                            Icons.store,
                            size: 16,
                            color: AppTheme.mediumGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _product['sellerShopName'],
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppTheme.mediumGrey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _product['sellerCity'],
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.mediumGrey,
                            ),
                          ),
                        ],
                      )
                          .animate(delay: const Duration(milliseconds: 200))
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .slideY(begin: 0.2, curve: Curves.easeOut),

                      const SizedBox(height: 12),

                      // Rating
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < _product['rating'].floor()
                                    ? Icons.star
                                    : index < _product['rating']
                                        ? Icons.star_half
                                        : Icons.star_border,
                                size: 20,
                                color: AppTheme.badgeGold,
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _product['rating'].toString(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${_product['reviewsCount']} reviews)',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.mediumGrey,
                            ),
                          ),
                        ],
                      )
                          .animate(delay: const Duration(milliseconds: 400))
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .slideY(begin: 0.2, curve: Curves.easeOut),

                      const SizedBox(height: 16),

                      // Price
                      Row(
                        children: [
                          Text(
                            '${_product['price'].toStringAsFixed(0)} ${_product['currency']}',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryGreen,
                            ),
                          ),
                          if (originalPrice != null) ...[
                            const SizedBox(width: 12),
                            Text(
                              '${originalPrice.toStringAsFixed(0)} ${_product['currency']}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppTheme.mediumGrey,
                              ),
                            ),
                          ],
                        ],
                      )
                          .animate(delay: const Duration(milliseconds: 600))
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .slideY(begin: 0.2, curve: Curves.easeOut),

                      const SizedBox(height: 16),

                      // Stock status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _product['stockQuantity'] > 0
                              ? AppTheme.success.withOpacity(0.1)
                              : AppTheme.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _product['stockQuantity'] > 0
                                  ? Icons.check_circle
                                  : Icons.error,
                              size: 16,
                              color: _product['stockQuantity'] > 0
                                  ? AppTheme.success
                                  : AppTheme.error,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _product['stockQuantity'] > 0
                                  ? '${_product['stockQuantity']} in stock'
                                  : 'Out of stock',
                              style: TextStyle(
                                color: _product['stockQuantity'] > 0
                                    ? AppTheme.success
                                    : AppTheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate(delay: const Duration(milliseconds: 800))
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .slideY(begin: 0.2, curve: Curves.easeOut),
                    ],
                  ),
                ),

                const Divider(),

                // Description
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _product['description'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ],
                  ),
                ),

                const Divider(),

                // Specifications
                if (_product['specifications'] != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Specifications',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 12),
                        ...(_product['specifications'] as Map<String, dynamic>)
                            .entries
                            .map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    entry.key,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.mediumGrey,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    entry.value.toString(),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  const Divider(),
                ],

                const SizedBox(height: 100), // Space for bottom bar
              ],
            ),
          ),
        ],
      ),

      // Bottom bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity selector
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: _quantity > 1
                          ? () {
                              setState(() {
                                _quantity--;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.remove),
                      iconSize: 20,
                    ),
                    Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Text(
                        _quantity.toString(),
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    IconButton(
                      onPressed: _quantity < _product['stockQuantity']
                          ? () {
                              setState(() {
                                _quantity++;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.add),
                      iconSize: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Add to cart button
              Expanded(
                child: ElevatedButton(
                  onPressed: _product['stockQuantity'] > 0 && !_isAddingToCart
                      ? _addToCart
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: _isAddingToCart
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_cart),
                            const SizedBox(width: 8),
                            Text(
                              'Add to Cart • ${(_product['price'] * _quantity).toStringAsFixed(0)} ETB',
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

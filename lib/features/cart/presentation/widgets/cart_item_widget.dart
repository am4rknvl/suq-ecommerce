import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;
  final Duration animationDelay;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.animationDelay,
  });

  @override
  Widget build(BuildContext context) {
    final product = cartItem['product'] as Map<String, dynamic>;
    final quantity = cartItem['quantity'] as int;
    final totalPrice = product['price'] * quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product image
              GestureDetector(
                onTap: () {
                  context.pushNamed('product-details', pathParameters: {
                    'productId': product['id'],
                  });
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.image,
                    size: 32,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    GestureDetector(
                      onTap: () {
                        context.pushNamed('product-details', pathParameters: {
                          'productId': product['id'],
                        });
                      },
                      child: Text(
                        product['name'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Seller name
                    Text(
                      product['sellerName'] ?? 'Unknown Seller',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.mediumGrey,
                          ),
                    ),

                    const SizedBox(height: 8),

                    // Price and quantity controls
                    Row(
                      children: [
                        // Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${product['price'].toStringAsFixed(0)} ETB',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryGreen,
                              ),
                            ),
                            if (quantity > 1)
                              Text(
                                'Total: ${totalPrice.toStringAsFixed(0)} ETB',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.mediumGrey,
                                ),
                              ),
                          ],
                        ),

                        const Spacer(),

                        // Quantity controls
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (quantity > 1) {
                                    onQuantityChanged(quantity - 1);
                                  }
                                },
                                icon: const Icon(Icons.remove),
                                iconSize: 18,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                              Container(
                                width: 32,
                                alignment: Alignment.center,
                                child: Text(
                                  quantity.toString(),
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  final maxQuantity = product['stockQuantity'] ?? 99;
                                  if (quantity < maxQuantity) {
                                    onQuantityChanged(quantity + 1);
                                  }
                                },
                                icon: const Icon(Icons.add),
                                iconSize: 18,
                                constraints: const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Remove button
              IconButton(
                onPressed: onRemove,
                icon: Icon(
                  Icons.delete_outline,
                  color: AppTheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate(delay: animationDelay)
        .fadeIn(duration: const Duration(milliseconds: 400))
        .slideX(begin: 0.2, curve: Curves.easeOut);
  }
}

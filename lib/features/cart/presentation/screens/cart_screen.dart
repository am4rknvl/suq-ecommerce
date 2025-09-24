import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/storage_service.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/cart_summary_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> _cartItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _cartItems = StorageService.getCartItems();
          _isLoading = false;
        });
      }
    });
  }

  void _updateQuantity(String productId, int newQuantity) async {
    if (newQuantity <= 0) {
      _removeItem(productId);
      return;
    }

    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item['productId'] == productId,
      );
      if (index >= 0) {
        _cartItems[index]['quantity'] = newQuantity;
      }
    });

    await StorageService.saveCartItems(_cartItems);
  }

  void _removeItem(String productId) async {
    setState(() {
      _cartItems.removeWhere((item) => item['productId'] == productId);
    });

    await StorageService.saveCartItems(_cartItems);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item removed from cart'),
          backgroundColor: AppTheme.success,
        ),
      );
    }
  }

  void _clearCart() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Are you sure you want to remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() {
                _cartItems.clear();
              });
              await StorageService.clearCart();
              
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cart cleared'),
                    backgroundColor: AppTheme.success,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  double get _subtotal {
    return _cartItems.fold(0.0, (sum, item) {
      final product = item['product'] as Map<String, dynamic>;
      final quantity = item['quantity'] as int;
      return sum + (product['price'] * quantity);
    });
  }

  double get _deliveryFee {
    return _subtotal > 500 ? 0.0 : 50.0; // Free delivery over 500 ETB
  }

  double get _total {
    return _subtotal + _deliveryFee;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
        ),
        body: _buildEmptyCart(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart (${_cartItems.length})'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _clearCart,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          // Cart items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = _cartItems[index];
                return CartItemWidget(
                  cartItem: cartItem,
                  onQuantityChanged: (newQuantity) {
                    _updateQuantity(cartItem['productId'], newQuantity);
                  },
                  onRemove: () {
                    _removeItem(cartItem['productId']);
                  },
                  animationDelay: Duration(milliseconds: index * 100),
                );
              },
            ),
          ),

          // Cart summary
          CartSummaryWidget(
            subtotal: _subtotal,
            deliveryFee: _deliveryFee,
            total: _total,
            onCheckout: () {
              context.pushNamed('checkout');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.lightGrey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: Colors.grey.shade400,
              ),
            )
                .animate()
                .scale(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                ),

            const SizedBox(height: 24),

            Text(
              'Your cart is empty',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
            )
                .animate(delay: const Duration(milliseconds: 200))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),

            const SizedBox(height: 8),

            Text(
              'Add some products to get started',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade500,
                  ),
              textAlign: TextAlign.center,
            )
                .animate(delay: const Duration(milliseconds: 400))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),

            const SizedBox(height: 32),

            ElevatedButton.icon(
              onPressed: () {
                // Navigate to browse products
                context.go('/home');
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Start Shopping'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            )
                .animate(delay: const Duration(milliseconds: 600))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),

            const SizedBox(height: 24),

            // Gamification encouragement
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.xpBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.xpBlue.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.stars,
                    color: AppTheme.xpBlue,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Earn XP with every purchase!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.xpBlue,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level up and unlock exclusive badges',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.mediumGrey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
                .animate(delay: const Duration(milliseconds: 800))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(begin: 0.3, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }
}

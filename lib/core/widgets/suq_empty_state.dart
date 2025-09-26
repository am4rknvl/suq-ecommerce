import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../theme/suq_colors.dart';
import '../theme/suq_typography.dart';
import 'suq_button.dart';

/// SUQ Empty State Component
/// Engaging empty states with illustrations and clear actions
class SuqEmptyState extends StatelessWidget {
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? illustration;
  final String? lottieAsset;
  final EmptyStateType type;
  
  const SuqEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.actionText,
    this.onAction,
    this.illustration,
    this.lottieAsset,
    this.type = EmptyStateType.general,
  });
  
  const SuqEmptyState.cart({
    super.key,
    this.title = 'Your cart is empty',
    this.description = 'Looks like you haven\'t added anything to your cart yet. Start shopping to fill it up!',
    this.actionText = 'Start Shopping',
    this.onAction,
    this.illustration,
    this.lottieAsset,
  }) : type = EmptyStateType.cart;
  
  const SuqEmptyState.wishlist({
    super.key,
    this.title = 'No items in wishlist',
    this.description = 'Save items you love by tapping the heart icon. They\'ll appear here for easy access.',
    this.actionText = 'Explore Products',
    this.onAction,
    this.illustration,
    this.lottieAsset,
  }) : type = EmptyStateType.wishlist;
  
  const SuqEmptyState.search({
    super.key,
    this.title = 'No results found',
    this.description = 'We couldn\'t find any products matching your search. Try different keywords or browse categories.',
    this.actionText = 'Browse Categories',
    this.onAction,
    this.illustration,
    this.lottieAsset,
  }) : type = EmptyStateType.search;
  
  const SuqEmptyState.orders({
    super.key,
    this.title = 'No orders yet',
    this.description = 'When you place your first order, it will appear here. Start shopping to see your order history.',
    this.actionText = 'Start Shopping',
    this.onAction,
    this.illustration,
    this.lottieAsset,
  }) : type = EmptyStateType.orders;
  
  const SuqEmptyState.network({
    super.key,
    this.title = 'Connection problem',
    this.description = 'Please check your internet connection and try again.',
    this.actionText = 'Retry',
    this.onAction,
    this.illustration,
    this.lottieAsset,
  }) : type = EmptyStateType.network;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            _buildIllustration(colorScheme),
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            
            // Description
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Action Button
            if (actionText != null && onAction != null)
              SuqButton.primary(
                text: actionText!,
                onPressed: onAction,
                size: SuqButtonSize.large,
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildIllustration(ColorScheme colorScheme) {
    // If custom illustration is provided
    if (illustration != null) {
      return SizedBox(
        height: 200,
        child: illustration!,
      );
    }
    
    // If Lottie asset is provided
    if (lottieAsset != null) {
      return SizedBox(
        height: 200,
        child: Lottie.asset(
          lottieAsset!,
          fit: BoxFit.contain,
        ),
      );
    }
    
    // Default illustrations based on type
    return SizedBox(
      height: 200,
      child: _getDefaultIllustration(colorScheme),
    );
  }
  
  Widget _getDefaultIllustration(ColorScheme colorScheme) {
    IconData iconData;
    Color iconColor;
    
    switch (type) {
      case EmptyStateType.cart:
        iconData = Icons.shopping_cart_outlined;
        iconColor = SuqColors.primary;
        break;
      case EmptyStateType.wishlist:
        iconData = Icons.favorite_border;
        iconColor = SuqColors.error;
        break;
      case EmptyStateType.search:
        iconData = Icons.search_off;
        iconColor = SuqColors.accent;
        break;
      case EmptyStateType.orders:
        iconData = Icons.receipt_long_outlined;
        iconColor = SuqColors.secondary;
        break;
      case EmptyStateType.network:
        iconData = Icons.wifi_off;
        iconColor = SuqColors.warning;
        break;
      case EmptyStateType.general:
      default:
        iconData = Icons.inbox_outlined;
        iconColor = colorScheme.onSurfaceVariant;
        break;
    }
    
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 64,
        color: iconColor,
      ),
    );
  }
}

enum EmptyStateType {
  general,
  cart,
  wishlist,
  search,
  orders,
  network,
}

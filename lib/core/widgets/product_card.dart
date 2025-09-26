import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/suq_colors.dart';
import '../theme/suq_typography.dart';
import 'suq_button.dart';

/// Product Card Component
/// Modern product card with hover effects and consistent styling
class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final String? badge;
  final bool isWishlisted;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onAddToCart;
  final ProductCardType type;
  
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    this.badge,
    this.isWishlisted = false,
    this.onTap,
    this.onWishlistTap,
    this.onAddToCart,
    this.type = ProductCardType.grid,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _isHovered 
                  ? SuqColors.shadowLight.withOpacity(0.15)
                  : SuqColors.shadowLight.withOpacity(0.08),
                blurRadius: _isHovered ? 12 : 8,
                offset: Offset(0, _isHovered ? 6 : 2),
              ),
            ],
          ),
          child: widget.type == ProductCardType.grid 
            ? _buildGridCard(theme, colorScheme)
            : _buildListCard(theme, colorScheme),
        ),
      ),
    );
  }
  
  Widget _buildGridCard(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Section
        Expanded(
          flex: 3,
          child: _buildImageSection(colorScheme),
        ),
        
        // Content Section
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                
                // Rating
                _buildRating(theme),
                const SizedBox(height: 8),
                
                // Price
                _buildPrice(theme, colorScheme),
                const Spacer(),
                
                // Add to Cart Button
                SuqButton.primary(
                  text: 'Add to Cart',
                  onPressed: widget.onAddToCart,
                  size: SuqButtonSize.small,
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildListCard(ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.surfaceContainerHighest,
            ),
            child: _buildImage(),
          ),
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                _buildRating(Theme.of(context)),
                const SizedBox(height: 4),
                _buildPrice(Theme.of(context), colorScheme),
              ],
            ),
          ),
          
          // Actions
          Column(
            children: [
              IconButton(
                onPressed: widget.onWishlistTap,
                icon: Icon(
                  widget.isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: widget.isWishlisted ? SuqColors.error : colorScheme.onSurfaceVariant,
                ),
              ),
              SuqButton.primary(
                text: 'Add',
                onPressed: widget.onAddToCart,
                size: SuqButtonSize.small,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildImageSection(ColorScheme colorScheme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        color: colorScheme.surfaceContainerHighest,
      ),
      child: Stack(
        children: [
          // Image
          Positioned.fill(child: _buildImage()),
          
          // Badge
          if (widget.badge != null)
            Positioned(
              top: 8,
              right: 8,
              child: _buildBadge(colorScheme),
            ),
          
          // Wishlist Button
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: widget.onWishlistTap,
                icon: Icon(
                  widget.isWishlisted ? Icons.favorite : Icons.favorite_border,
                  color: widget.isWishlisted ? SuqColors.error : colorScheme.onSurfaceVariant,
                  size: 20,
                ),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildImage() {
    return ClipRRect(
      borderRadius: widget.type == ProductCardType.grid 
        ? const BorderRadius.vertical(top: Radius.circular(12))
        : BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Icon(
            Icons.image_not_supported,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
  
  Widget _buildBadge(ColorScheme colorScheme) {
    Color badgeColor;
    switch (widget.badge?.toLowerCase()) {
      case 'new':
        badgeColor = SuqColors.badgeNew;
        break;
      case 'sale':
        badgeColor = SuqColors.badgeSale;
        break;
      case 'out of stock':
        badgeColor = SuqColors.badgeOutOfStock;
        break;
      default:
        badgeColor = colorScheme.primary;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.badge!,
        style: SuqTypography.overlineStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
  Widget _buildRating(ThemeData theme) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          return Icon(
            index < widget.rating.floor() 
              ? Icons.star
              : (index < widget.rating ? Icons.star_half : Icons.star_border),
            color: SuqColors.gold,
            size: 14,
          );
        }),
        const SizedBox(width: 4),
        Text(
          '${widget.rating} (${widget.reviewCount})',
          style: SuqTypography.captionStyle(
            color: theme.colorScheme.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
  
  Widget _buildPrice(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      children: [
        Text(
          'ETB ${widget.price.toStringAsFixed(0)}',
          style: SuqTypography.priceStyle(
            color: colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (widget.originalPrice != null) ...[
          const SizedBox(width: 8),
          Text(
            'ETB ${widget.originalPrice!.toStringAsFixed(0)}',
            style: SuqTypography.captionStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 12,
            ).copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}

enum ProductCardType {
  grid,
  list,
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/suq_colors.dart';

/// SUQ Loading Components
/// Modern loading states with shimmer effects and animations
class SuqLoading {
  
  /// Circular loading indicator
  static Widget circular({
    Color? color,
    double size = 24,
  }) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? SuqColors.primary,
        ),
      ),
    );
  }
  
  /// Linear loading indicator
  static Widget linear({
    Color? color,
    Color? backgroundColor,
  }) {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color ?? SuqColors.primary,
      ),
      backgroundColor: backgroundColor ?? SuqColors.surfaceVariantLight,
    );
  }
  
  /// Shimmer loading effect
  static Widget shimmer({
    required Widget child,
    bool isLoading = true,
  }) {
    if (!isLoading) return child;
    
    return child
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: const Duration(milliseconds: 1500),
          color: Colors.white.withOpacity(0.6),
        );
  }
  
  /// Product card skeleton
  static Widget productCardSkeleton() {
    return Container(
      decoration: BoxDecoration(
        color: SuqColors.surfaceVariantLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: SuqColors.outlineLight,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),
          ),
          
          // Content skeleton
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title skeleton
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: SuqColors.outlineLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 16,
                    width: 120,
                    decoration: BoxDecoration(
                      color: SuqColors.outlineLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Rating skeleton
                  Row(
                    children: [
                      ...List.generate(5, (index) => Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: SuqColors.outlineLight,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      )),
                      const SizedBox(width: 8),
                      Container(
                        height: 12,
                        width: 60,
                        decoration: BoxDecoration(
                          color: SuqColors.outlineLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Price skeleton
                  Container(
                    height: 20,
                    width: 80,
                    decoration: BoxDecoration(
                      color: SuqColors.outlineLight,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  
                  // Button skeleton
                  Container(
                    height: 36,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: SuqColors.outlineLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat())
     .shimmer(duration: const Duration(milliseconds: 1500));
  }
  
  /// List item skeleton
  static Widget listItemSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Image skeleton
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: SuqColors.outlineLight,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          
          // Content skeleton
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: SuqColors.outlineLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 14,
                  width: 100,
                  decoration: BoxDecoration(
                    color: SuqColors.outlineLight,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat())
     .shimmer(duration: const Duration(milliseconds: 1500));
  }
  
  /// Page loading overlay
  static Widget pageOverlay({
    String? message,
  }) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: SuqColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              circular(size: 32),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

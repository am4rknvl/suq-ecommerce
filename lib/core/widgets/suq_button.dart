import 'package:flutter/material.dart';
import '../theme/suq_colors.dart';
import '../theme/suq_typography.dart';

/// SUQ Button Component
/// Modern button with micro-interactions and consistent styling
class SuqButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final SuqButtonType type;
  final SuqButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final Color? customColor;
  
  const SuqButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = SuqButtonType.primary,
    this.size = SuqButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
  });
  
  const SuqButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = SuqButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
  }) : type = SuqButtonType.primary;
  
  const SuqButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = SuqButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
  }) : type = SuqButtonType.secondary;
  
  const SuqButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.size = SuqButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.customColor,
  }) : type = SuqButtonType.text;

  @override
  State<SuqButton> createState() => _SuqButtonState();
}

class _SuqButtonState extends State<SuqButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Button dimensions based on size
    final buttonHeight = _getButtonHeight();
    final horizontalPadding = _getHorizontalPadding();
    final fontSize = _getFontSize();
    
    // Button colors based on type
    final backgroundColor = _getBackgroundColor(colorScheme);
    final foregroundColor = _getForegroundColor(colorScheme);
    final borderColor = _getBorderColor(colorScheme);
    
    Widget buttonChild = _buildButtonContent(foregroundColor, fontSize);
    
    if (widget.isFullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        child: buttonChild,
      );
    }
    
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_isPressed ? 0.98 : 1.0),
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          elevation: widget.type == SuqButtonType.primary ? 2 : 0,
          shadowColor: SuqColors.shadowLight,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: buttonHeight,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: borderColor != null 
                  ? Border.all(color: borderColor!, width: 2)
                  : null,
              ),
              child: buttonChild,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildButtonContent(Color foregroundColor, double fontSize) {
    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
          ),
        ),
      );
    }
    
    final textWidget = Text(
      widget.text,
      style: SuqTypography.buttonStyle(
        color: foregroundColor,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
    
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(color: foregroundColor, size: fontSize + 2),
            child: widget.icon!,
          ),
          const SizedBox(width: 8),
          textWidget,
        ],
      );
    }
    
    return Center(child: textWidget);
  }
  
  double _getButtonHeight() {
    switch (widget.size) {
      case SuqButtonSize.small:
        return 36;
      case SuqButtonSize.medium:
        return 48;
      case SuqButtonSize.large:
        return 56;
    }
  }
  
  double _getHorizontalPadding() {
    switch (widget.size) {
      case SuqButtonSize.small:
        return 16;
      case SuqButtonSize.medium:
        return 24;
      case SuqButtonSize.large:
        return 32;
    }
  }
  
  double _getFontSize() {
    switch (widget.size) {
      case SuqButtonSize.small:
        return 12;
      case SuqButtonSize.medium:
        return 14;
      case SuqButtonSize.large:
        return 16;
    }
  }
  
  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (widget.customColor != null && widget.type == SuqButtonType.primary) {
      return widget.customColor!;
    }
    
    switch (widget.type) {
      case SuqButtonType.primary:
        return colorScheme.primary;
      case SuqButtonType.secondary:
        return Colors.transparent;
      case SuqButtonType.text:
        return Colors.transparent;
    }
  }
  
  Color _getForegroundColor(ColorScheme colorScheme) {
    if (widget.customColor != null) {
      switch (widget.type) {
        case SuqButtonType.primary:
          return Colors.white;
        case SuqButtonType.secondary:
        case SuqButtonType.text:
          return widget.customColor!;
      }
    }
    
    switch (widget.type) {
      case SuqButtonType.primary:
        return colorScheme.onPrimary;
      case SuqButtonType.secondary:
      case SuqButtonType.text:
        return colorScheme.primary;
    }
  }
  
  Color? _getBorderColor(ColorScheme colorScheme) {
    switch (widget.type) {
      case SuqButtonType.primary:
      case SuqButtonType.text:
        return null;
      case SuqButtonType.secondary:
        return widget.customColor ?? colorScheme.primary;
    }
  }
}

enum SuqButtonType {
  primary,
  secondary,
  text,
}

enum SuqButtonSize {
  small,
  medium,
  large,
}

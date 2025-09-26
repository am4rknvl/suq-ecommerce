import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/suq_typography.dart';

/// SUQ Input Field Component
/// Modern input field with floating labels and consistent styling
class SuqInputField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final EdgeInsets? contentPadding;
  
  const SuqInputField({
    super.key,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.textInputAction,
    this.autofocus = false,
    this.contentPadding,
  });
  
  const SuqInputField.email({
    super.key,
    this.label = 'Email',
    this.hint = 'Enter your email',
    this.helperText,
    this.errorText,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon = const Icon(Icons.email_outlined),
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.autofocus = false,
    this.contentPadding,
  }) : keyboardType = TextInputType.emailAddress,
       obscureText = false,
       maxLines = 1,
       maxLength = null;
  
  const SuqInputField.password({
    super.key,
    this.label = 'Password',
    this.hint = 'Enter your password',
    this.helperText,
    this.errorText,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon = const Icon(Icons.lock_outlined),
    Widget? suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.autofocus = false,
    this.contentPadding,
  }) : keyboardType = TextInputType.visiblePassword,
       obscureText = true,
       maxLines = 1,
       maxLength = null,
       suffixIcon = suffixIcon;
  
  const SuqInputField.search({
    super.key,
    this.label,
    this.hint = 'Search...',
    this.helperText,
    this.errorText,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon = const Icon(Icons.search),
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.search,
    this.autofocus = false,
    this.contentPadding,
  }) : keyboardType = TextInputType.text,
       obscureText = false,
       maxLines = 1,
       maxLength = null;

  @override
  State<SuqInputField> createState() => _SuqInputFieldState();
}

class _SuqInputFieldState extends State<SuqInputField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;
  
  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;
    _focusNode.addListener(_onFocusChange);
  }
  
  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }
  
  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffixIcon(colorScheme),
            contentPadding: widget.contentPadding ?? 
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            
            // Border styling
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
            ),
            
            // Fill styling
            filled: true,
            fillColor: widget.enabled 
              ? colorScheme.surface 
              : colorScheme.surfaceContainerHighest.withOpacity(0.5),
            
            // Text styling
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            labelStyle: theme.textTheme.bodyMedium?.copyWith(
              color: _isFocused 
                ? colorScheme.primary 
                : colorScheme.onSurfaceVariant,
            ),
            floatingLabelStyle: theme.textTheme.bodySmall?.copyWith(
              color: widget.errorText != null 
                ? colorScheme.error 
                : colorScheme.primary,
            ),
            errorStyle: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
            ),
            
            // Icon styling
            prefixIconColor: _isFocused 
              ? colorScheme.primary 
              : colorScheme.onSurfaceVariant,
            suffixIconColor: colorScheme.onSurfaceVariant,
          ),
        ),
        
        // Helper text
        if (widget.helperText != null && widget.errorText == null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 16),
            child: Text(
              widget.helperText!,
              style: SuqTypography.captionStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
  
  Widget? _buildSuffixIcon(ColorScheme colorScheme) {
    if (widget.obscureText) {
      return IconButton(
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }
    
    return widget.suffixIcon;
  }
}

import 'package:flutter/material.dart';

import '../../core/utils/screen_util_like.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool isRequired;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final Widget? prefixIcon;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool filled;
  final Color? fillColor;
  final Color? borderColor;
  final bool enabled;

  const CustomDropdownField({
    super.key,
    this.label,
    this.hintText,
    this.isRequired = false,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
    this.prefixIcon,
    this.borderRadius = 12.0,
    this.contentPadding,
    this.filled = true,
    this.fillColor,
    this.borderColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBorderRadius = BorderRadius.circular(borderRadius.r);

    final defaultEnabledBorder = OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: BorderSide(
        color: borderColor ?? theme.colorScheme.outline.withValues(alpha: 0.3),
        width: 1.0,
      ),
    );

    final defaultFocusedBorder = OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
    );

    final defaultErrorBorder = OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: BorderSide(color: theme.colorScheme.error, width: 1.0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              if (isRequired) ...[
                SizedBox(width: 4.w),
                Text(
                  '*',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.h),
        ],
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          dropdownColor: theme.colorScheme.surface,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            filled: filled,
            fillColor:
                fillColor ??
                theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.3,
                ),
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            prefixIcon: prefixIcon,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: defaultEnabledBorder,
            enabledBorder: defaultEnabledBorder,
            focusedBorder: defaultFocusedBorder,
            errorBorder: defaultErrorBorder,
            focusedErrorBorder: defaultErrorBorder,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MultiTextButton extends StatelessWidget {
  final List<Text> children;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final MainAxisAlignment alignment;
  final double? spacing;

  const MultiTextButton({
    super.key,
    required this.children,
    required this.onPressed,
    this.style,
    this.padding,
    this.icon,
    this.alignment = MainAxisAlignment.center,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: style,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: alignment,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: spacing ?? 8.0),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}
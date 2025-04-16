import 'package:avicultura_app/common/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController? controller;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final String? labelText;
  final TextStyle? hinStyle;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final String? helperText;
  final bool? obscureText;

  const PasswordFormField({
    super.key,
    this.controller,
    this.padding,
    this.hintText,
    this.labelText,
    this.backgroundColor,
    this.hinStyle,
    this.validator,
    this.helperText,
    required this.obscureText,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      helperText: widget.helperText,
      validator: widget.validator,
      obscureText: isHidden,
      controller: widget.controller,
      padding: widget.padding,
      hintText: widget.hintText,
      hinStyle: widget.hinStyle,
      labelText: widget.labelText,
      backgroundColor: widget.backgroundColor,
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        child: Icon(
          isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onTap: () {
          debugPrint('pressed');
          setState(() {
            isHidden = !isHidden;
          });
        },
      ),
    );
  }
}

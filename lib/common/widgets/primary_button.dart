import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.text, this.onPressed});

  final BorderRadius _borderRadius = const BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: _borderRadius,
      child: Ink(
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: onPressed !=null ? AppColors.primary : AppColors.desable,
          ),
          child: InkWell(
            borderRadius: _borderRadius,
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: _borderRadius,
              ),
              alignment: Alignment.center,
              height: 56.0,
              width: 350.0,
              child: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700
                ).copyWith(color: AppColors.white),
              ),
            ),
          )
      ),
    );
  }
}
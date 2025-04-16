import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/app_text_styles.dart';
import 'package:avicultura_app/common/widgets/primary_button.dart';
import 'package:flutter/material.dart';

Future<void> customModalBottomSheet(
    BuildContext context, {
      required String content,
      required String buttonText,
      VoidCallback? onPressed,
}) {
  return showModalBottomSheet<void>(
            context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(38.0),
              topRight: Radius.circular(38.0),
            ),
          ),
          builder: (BuildContext context) {
              return Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38.0),
                          topRight: Radius.circular(38.0),
                  ),
                ),
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(content,
                      style: AppTextStyles.subtitulos.copyWith(color: AppColors.textDark),
                      ),
                      const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0
                          )
                      ),
                      PrimaryButton(
                        text: buttonText,
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              );
          }
        );
      }
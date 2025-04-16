import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/app_text_styles.dart';
import 'package:avicultura_app/common/constants/routes.dart';
import 'package:avicultura_app/common/widgets/primary_button.dart';
import 'package:avicultura_app/common/widgets/multi_text_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 3.0,
                  right: 3.0,
                  top: 25.0
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Seu controle',
                    style: AppTextStyles.destaque.copyWith(color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  PrimaryButton(
                    text: 'Vamos começar',
                    onPressed: () {
                      Navigator.pushNamed(
                          context,
                          NamedRoute.signUp
                      );
                    },
                  ),
                  const SizedBox(height: 10.0),

                  MultiTextButton(
                    onPressed: () => Navigator.pushNamed(context, NamedRoute.signIn),
                    children: [
                      Text(
                        'Já tem conta?',
                        style: AppTextStyles.subtitulos.copyWith(
                            color: AppColors.textDark
                        ),
                      ),
                      Text(
                          ' Acesse',
                          style: AppTextStyles.subtitulos.copyWith(color: AppColors.primary)
                      )
                    ],
                  ),
                  const SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
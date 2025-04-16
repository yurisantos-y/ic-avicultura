import 'package:avicultura_app/common/constants/routes.dart';
import 'package:avicultura_app/features/home/home_page.dart';
import 'package:avicultura_app/features/onboarding/onboarding_page.dart';
import 'package:avicultura_app/features/relatorio/relatorio_page.dart';
import 'package:avicultura_app/features/sign_in/sign_in_page.dart';
import 'package:avicultura_app/features/sign_up/sign_up_page.dart';
import 'package:avicultura_app/features/splash/splash_page.dart';
import 'package:avicultura_app/features/user_profile/post_registration_form_page.dart';
import 'package:avicultura_app/features/user_profile/user_profile_page.dart';
import 'package:avicultura_app/features/vaccine/vaccine_control_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: defaultTheme,
      initialRoute: NamedRoute.splash,
      routes: {
        NamedRoute.initial:(context) => const OnboardingPage(),
        NamedRoute.splash: (context) => const SplashPage(),
        NamedRoute.signUp: (context) => const SignUpPage(),
        NamedRoute.signIn: (context) => const SignInPage(),
        NamedRoute.home: (context) => const HomePage(),
        NamedRoute.relatorio: (context) => const RelatorioPage(),
        NamedRoute.postRegistration: (context) => const PostRegistrationFormPage(),
        NamedRoute.vaccineControl: (context) => const VaccineControlPage(),
        NamedRoute.userProfile: (context) => const UserProfilePage(),
      },
    );
  }
}

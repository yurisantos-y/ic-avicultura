import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/routes.dart';
import 'package:avicultura_app/common/extensions/sizes.dart';
import 'package:avicultura_app/features/splash/splash_controller.dart';
import 'package:avicultura_app/features/splash/splash_state.dart';
import 'package:avicultura_app/locator.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final _splashController = locator.get<SplashController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => Sizes.init(context));

    _splashController.isUserLogged();
    _splashController.addListener(() {
      if (_splashController.state is SplashStateSuccess) {
        Navigator.pushReplacementNamed(
            context,
            NamedRoute.home
        );
      } else {
        Navigator.pushReplacementNamed(
            context,
            NamedRoute.initial
        );
      }
    });
  }

  @override
  void dispose() {
    _splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: AppColors.white,
        child: Image.asset('assets/images/logo.png',
          width: 200,
          height: 100,
        ),
      ),
    );
  }
}

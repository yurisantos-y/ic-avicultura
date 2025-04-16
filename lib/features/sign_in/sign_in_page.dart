import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/app_text_styles.dart';
import 'package:avicultura_app/common/constants/routes.dart';
import 'package:avicultura_app/common/utils/validator.dart';
import 'package:avicultura_app/common/widgets/custom_bottom_sheet.dart';
import 'package:avicultura_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:avicultura_app/common/widgets/custom_text_field.dart';
import 'package:avicultura_app/common/widgets/multi_text_button.dart';
import 'package:avicultura_app/common/widgets/password_form_field.dart';
import 'package:avicultura_app/common/widgets/primary_button.dart';
import 'package:avicultura_app/features/sign_in/sign_in_controller.dart';
import 'package:avicultura_app/features/sign_in/sign_in_state.dart';
import 'package:avicultura_app/locator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDay;
  String? selectedMonth;
  String? selectedYear;

  final List<String> days = List.generate(31, (index) => (index + 1).toString());
  final List<String> months = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
  ];
  final List<String> years = List.generate(2024 - 1900 + 1, (index) => (1900 + index).toString());

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _controller = locator.get<SignInController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.state is SignInStateLoading) {
        showDialog(
          context: context,
          builder: (context) => const CustomCircularProgressIndicator(),
        );
      }
      if (_controller.state is SignInStateSuccess) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(
            context,
          NamedRoute.home
        );
      }
      if (_controller.state is SignInStateError) {
        final error = _controller.state as SignInStateError;
        Navigator.pop(context);
        customModalBottomSheet(
          context,
          content: error.message,
          buttonText: "Tentar novamente",
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
            child: InkWell(
              onTap: () {},
              child: const Wrap(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Acesse',
              style: AppTextStyles.heading.copyWith(color: AppColors.textDark),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Com e-mail e senha para entrar',
              style: AppTextStyles.subtitulos.copyWith(color: AppColors.textDark),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  labelText: "E-mail",
                  hintText: "Digite seu e-mail",
                  backgroundColor: AppColors.bgForm,
                  obscureText: false,
                  hinStyle: AppTextStyles.subtitulos.copyWith(color: AppColors.textForm),
                  validator: Validator.validateEmail,
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Senha",
                  hintText: "Digite sua senha",
                  backgroundColor: AppColors.bgForm,
                  hinStyle: const TextStyle(color: AppColors.textForm),
                  obscureText: false,
                  validator: Validator.validatePassword,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 14.0, right: 14.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              text: 'Logar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                } else {
                  debugPrint('erro ao logar');
                }
              },
            ),
          ),
          MultiTextButton(
            children: [
              Text(
                'Nào possui uma conta? ',
                style: AppTextStyles.labels.copyWith(color: AppColors.textDark),
              ),
              Text(
                'Criar conta',
                style: AppTextStyles.labels.copyWith(color: AppColors.primary),
              )
            ],
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.signUp
            ),
          )
        ],
      ),
    );
  }
}
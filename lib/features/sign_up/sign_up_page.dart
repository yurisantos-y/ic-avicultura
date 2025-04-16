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
import 'package:avicultura_app/features/sign_up/sign_up_controller.dart';
import 'package:avicultura_app/features/sign_up/sign_up_state.dart';
import 'package:avicultura_app/locator.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
  final _controller = locator.get<SignUpController>();

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
      if (_controller.state is SignUpStateLoading) {
          showDialog(
            context: context,
            builder: (context) => const CustomCircularProgressIndicator(),
          );
      }
      if (_controller.state is SignUpStateSuccess) {
        Navigator.pop(context); // Close loading dialog
        
        // Redirect to post-registration form instead of home
        if (_controller.redirectToPostRegistration) {
          Navigator.pushReplacementNamed(
            context,
            NamedRoute.postRegistration
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            NamedRoute.home
          );
        }
      }
      if (_controller.state is SignUpStateError) {
        final error = _controller.state as SignUpStateError;
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
              'Cadastre-se',
              style: AppTextStyles.heading.copyWith(color: AppColors.textDark),
              textAlign: TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Informe seu e-mail e crie uma senha',
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
                CustomTextFormField(
                  labelText: "Repita seu e-mail",
                  hintText: "Repita seu e-mail",
                  backgroundColor: AppColors.bgForm,
                  obscureText: false,
                  hinStyle: AppTextStyles.subtitulos.copyWith(color: AppColors.textForm),
                  validator: (value) => Validator.validateConfirmEmail(
                      value,
                      _emailController.text
                  ),
                ),
                PasswordFormField(
                  controller: _passwordController,
                  labelText: "Crie uma senha",
                  hintText: "Digite sua senha",
                  backgroundColor: AppColors.bgForm,
                  hinStyle: const TextStyle(color: AppColors.textForm),
                  obscureText: false,
                  validator: Validator.validatePassword,
                ),
                PasswordFormField(
                  labelText: "Repita sua senha",
                  hintText: "Repita sua senha",
                  backgroundColor: AppColors.bgForm,
                  hinStyle: const TextStyle(color: AppColors.textForm),
                  obscureText: false,
                  validator: (value) => Validator.validateConfirmPassword(
                      value,
                      _passwordController.text),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data de Nascimento',
                        style: AppTextStyles.paragrafos,
                      ),
                      const SizedBox(height: 6.0),
                      Row(
                        children: [
                          SizedBox(
                            width: 97, // Largura do campo Dia
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Dia',
                                fillColor: AppColors.bgForm,
                                filled: true,
                              ),
                              value: selectedDay,
                              items: days.map((String day) {
                                return DropdownMenuItem<String>(
                                  value: day,
                                  child: Text(day),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedDay = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          SizedBox(
                            width: 150, // Largura do campo Mês
                            child: DropdownButtonFormField<String>(

                              decoration: const InputDecoration(

                                labelText: 'Mês',
                                fillColor: AppColors.bgForm,
                                filled: true,
                              ),
                              value: selectedMonth,
                              items: months.map((String month) {
                                return DropdownMenuItem<String>(
                                  value: month,
                                  child: Text(month),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedMonth = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          SizedBox(
                            width: 97, // Largura do campo Ano
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Ano',
                                fillColor: AppColors.bgForm,
                                filled: true,
                              ),
                              value: selectedYear,
                              items: years.map((String year) {
                                return DropdownMenuItem<String>(
                                  value: year,
                                  child: Text(year),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 14.0, right: 14.0, top: 16.0, bottom: 4.0),
            child: PrimaryButton(
              text: 'Cadastrar',
              onPressed: () {
                final valid = _formKey.currentState != null &&
                    _formKey.currentState!.validate();
                if (valid) {
                  _controller.signUp(
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
                'Já possui uma conta? ',
                style: AppTextStyles.labels.copyWith(color: AppColors.textDark),
              ),
              Text(
                'Acessar',
                style: AppTextStyles.labels.copyWith(color: AppColors.primary),
              )
            ],
            onPressed: () => Navigator.popAndPushNamed(
              context,
              NamedRoute.signIn
            ),
          )
        ],
      ),
    );
  }
}
import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/app_text_styles.dart';
import 'package:avicultura_app/common/constants/routes.dart';
import 'package:avicultura_app/common/models/user_model.dart';
import 'package:avicultura_app/common/widgets/custom_bottom_sheet.dart';
import 'package:avicultura_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:avicultura_app/common/widgets/custom_text_field.dart';
import 'package:avicultura_app/common/widgets/primary_button.dart';
import 'package:avicultura_app/services/firestore_service.dart';
import 'package:avicultura_app/services/secure_storage.dart';
import 'package:flutter/material.dart';

class PostRegistrationFormPage extends StatefulWidget {
  const PostRegistrationFormPage({super.key});

  @override
  State<PostRegistrationFormPage> createState() => _PostRegistrationFormPageState();
}

class _PostRegistrationFormPageState extends State<PostRegistrationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aviaryNameController = TextEditingController();
  final _firestoreService = FirestoreService();
  final _secureStorage = const SecureStorage();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _aviaryNameController.dispose();
    super.dispose();
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Get current user from secure storage
        final userJson = await _secureStorage.readOne(key: "CURRENT_USER");
        if (userJson == null) {
          throw "Usuário não encontrado";
        }

        final currentUser = UserModel.fromJson(userJson);
        
        // Create updated user with new data
        final updatedUser = currentUser.copyWith(
          name: _nameController.text,
          aviaryName: _aviaryNameController.text,
        );
        
        // Save to Firestore
        await _firestoreService.saveUserProfile(updatedUser);
        
        // Update secure storage with new user data
        await _secureStorage.write(
          key: "CURRENT_USER",
          value: updatedUser.toJson(),
        );
        
        // Navigate to home screen
        if (mounted) {
          Navigator.pushReplacementNamed(context, NamedRoute.home);
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context); // Close loading dialog
          
          customModalBottomSheet(
            context,
            content: "Erro ao salvar dados: ${e.toString()}",
            buttonText: "Tentar novamente",
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete seu perfil'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CustomCircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(
                      'Bem-vindo!',
                      style: AppTextStyles.heading.copyWith(color: AppColors.textDark),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Complete seu perfil para continuar',
                      style: AppTextStyles.subtitulos.copyWith(color: AppColors.textDark),
                    ),
                    const SizedBox(height: 32.0),
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: "Seu nome",
                      hintText: "Digite seu nome completo",
                      backgroundColor: AppColors.bgForm,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, informe seu nome";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      controller: _aviaryNameController,
                      labelText: "Nome do Aviário",
                      hintText: "Digite o nome do seu aviário",
                      backgroundColor: AppColors.bgForm,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Por favor, informe o nome do aviário";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    PrimaryButton(
                      text: 'Salvar e Continuar',
                      onPressed: _saveUserData,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
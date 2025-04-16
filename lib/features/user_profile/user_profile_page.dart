import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/models/user_model.dart';
import 'package:avicultura_app/common/widgets/custom_bottom_sheet.dart';
import 'package:avicultura_app/common/widgets/custom_circular_progress_indicator.dart';
import 'package:avicultura_app/common/widgets/custom_floating_bottom_navbar.dart';
import 'package:avicultura_app/common/widgets/custom_text_field.dart';
import 'package:avicultura_app/common/widgets/primary_button.dart';
import 'package:avicultura_app/services/firestore_service.dart';
import 'package:avicultura_app/services/secure_storage.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aviaryNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firestoreService = FirestoreService();
  final _secureStorage = const SecureStorage();
  bool _isLoading = true;
  bool _isSaving = false;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _aviaryNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    try {
      final userJson = await _secureStorage.readOne(key: "CURRENT_USER");
      if (userJson == null) {
        throw "Usuário não encontrado";
      }

      _currentUser = UserModel.fromJson(userJson);
      
      setState(() {
        _nameController.text = _currentUser?.name ?? '';
        _aviaryNameController.text = _currentUser?.aviaryName ?? '';
        _emailController.text = _currentUser?.email ?? '';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        customModalBottomSheet(
          context,
          content: "Erro ao carregar dados: ${e.toString()}",
          buttonText: "Fechar",
        );
      }
    }
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSaving = true;
      });

      try {
        if (_currentUser == null) {
          throw "Usuário não encontrado";
        }
        
        // Create updated user with new data
        final updatedUser = _currentUser!.copyWith(
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
        
        if (mounted) {
          customModalBottomSheet(
            context,
            content: "Perfil atualizado com sucesso!",
            buttonText: "OK",
          );
        }
      } catch (e) {
        if (mounted) {
          customModalBottomSheet(
            context,
            content: "Erro ao salvar dados: ${e.toString()}",
            buttonText: "Tentar novamente",
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CustomCircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24.0),
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
                    const SizedBox(height: 16.0),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: "E-mail",
                      hintText: "Seu e-mail",
                      backgroundColor: AppColors.bgForm,
                      obscureText: false,
                      readOnly: true,
                    ),
                    const SizedBox(height: 32.0),
                    _isSaving
                        ? const CustomCircularProgressIndicator()
                        : PrimaryButton(
                            text: 'Salvar Alterações',
                            onPressed: _saveUserData,
                          ),
                  ],
                ),
              ),
            ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomFloatingBottomNavbar(),
    );
  }
}
import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/app_text_styles.dart';
import 'package:avicultura_app/common/widgets/custom_floating_bottom_navbar.dart';
import 'package:flutter/material.dart';

class VaccineControlPage extends StatefulWidget {
  const VaccineControlPage({super.key});

  @override
  State<VaccineControlPage> createState() => _VaccineControlPageState();
}

class _VaccineControlPageState extends State<VaccineControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Vacina'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Controle de Vacinas',
              style: AppTextStyles.heading.copyWith(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Gerenciamento de vacinação do seu aviário',
              style: AppTextStyles.subtitulos.copyWith(color: AppColors.textDark),
            ),
            const SizedBox(height: 32.0),
            
            // Placeholder content - to be expanded later
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.vaccines,
                      size: 64.0,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Controle de vacinas em desenvolvimento',
                      style: AppTextStyles.subtitulos.copyWith(color: AppColors.textDark),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Em breve você poderá gerenciar todas as vacinas do seu aviário',
                      style: AppTextStyles.paragrafos,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomFloatingBottomNavbar(),
    );
  }
}
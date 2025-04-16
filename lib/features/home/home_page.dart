import 'package:flutter/material.dart';
import 'package:avicultura_app/common/constants/app_colors.dart';
import 'package:avicultura_app/common/constants/app_text_styles.dart';
import 'package:avicultura_app/common/constants/routes.dart';
import 'package:avicultura_app/common/models/relatorio/relatorio_model.dart';
import 'package:avicultura_app/common/models/user_model.dart';
import 'package:avicultura_app/common/widgets/custom_floating_bottom_navbar.dart';
import 'package:avicultura_app/services/relatorio_service/relatorio_service.dart';
import 'package:avicultura_app/services/secure_storage.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double get textScaleFactor =>
      MediaQuery.of(context).size.width < 360 ? 0.7 : 1.0;
  double get iconSize => MediaQuery.of(context).size.width < 360 ? 16.0 : 24.0;
  
  final SecureStorage _secureStorage = const SecureStorage();
  final RelatorioService _relatorioService = RelatorioService();
  String userName = '';
  String aviaryName = '';
  bool isLoading = true;
  List<RelatorioModel> latestRelatorios = [];
  
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  
  Future<void> _loadData() async {
    await _loadUserData();
    await _loadLatestRelatorios();
  }
  
  Future<void> _loadUserData() async {
    try {
      final userJson = await _secureStorage.readOne(key: "CURRENT_USER");
      if (userJson != null) {
        final userData = UserModel.fromJson(userJson);
        setState(() {
          userName = userData.name ?? 'Usuário';
          aviaryName = userData.aviaryName ?? 'Aviário';
          isLoading = false;
        });
      } else {
        setState(() {
          userName = 'Usuário';
          aviaryName = 'Aviário';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        userName = 'Usuário';
        aviaryName = 'Aviário';
        isLoading = false;
      });
    }
  }
  
  Future<void> _loadLatestRelatorios() async {
    try {
      debugPrint('Iniciando carregamento de relatórios');
      final relatorios = await _relatorioService.getLatestRelatorios();
      debugPrint('Relatórios carregados: ${relatorios.length}');
      if (mounted) {
        setState(() {
          latestRelatorios = relatorios;
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar relatórios: $e');
    }
  }
  
  String _formatDateFromId(String id) {
    try {
      // Assumindo que o ID começa com um timestamp ou contém informação de data
      // Esta é uma implementação simplificada, adapte conforme necessário
      DateTime now = DateTime.now();
      return DateFormat('dd/MM').format(now);
    } catch (e) {
      return 'Data desconhecida';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: isLoading 
      ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
      : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, $userName',
                  style: AppTextStyles.heading.copyWith(fontSize: 24.0),
                ),
                const SizedBox(height: 4.0),
                Text(
                  aviaryName,
                  style: AppTextStyles.subtitulos.copyWith(
                    color: AppColors.textDark.withOpacity(0.7),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Row(
              children: [
                // Relatório ocupando 70% da largura da tela
                GestureDetector(
                  onTap: () => _showReportsModal(context),
                  child: Container(
                    width: screenWidth * 0.7,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.description, color: AppColors.primary),
                            SizedBox(width: 8.0),
                            Text(
                              'Últimos Relatórios',
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        latestRelatorios.isEmpty
                            ? const Text(
                                'Nenhum relatório encontrado',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            : Column(
                                children: latestRelatorios.take(3).map((relatorio) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.assignment_outlined,
                                          color: AppColors.primary.withOpacity(0.7),
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            'Relatório do Aviário ${relatorio.nrAviario}',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          _formatDateFromId(relatorio.id),
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                        if (latestRelatorios.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Ver todos',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.primary,
                                  size: 12.0,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Espaço para o botão
                const SizedBox(width: 16.0),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  foregroundColor: AppColors.primary,
                  onPressed: () {},
                  child: const Text(
                    '30º',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            GestureDetector(
              onTap: () {
                // Navigate to the Vaccine Control page
                Navigator.pushNamed(context, NamedRoute.vaccineControl);
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.vaccines, color: AppColors.primary),
                    const SizedBox(width: 8.0),
                    Text(
                      'Controle de Vacina',
                      style: AppTextStyles.subheading.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward, color: AppColors.primary),
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
  
  void _showReportsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Relatórios Recentes',
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 20.0,
                      color: AppColors.textDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: latestRelatorios.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 48.0,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'Nenhum relatório encontrado',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, NamedRoute.relatorio);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                              ),
                              child: const Text('Criar Relatório'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: latestRelatorios.length,
                        itemBuilder: (context, index) {
                          final relatorio = latestRelatorios[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 2.0,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              leading: const CircleAvatar(
                                backgroundColor: AppColors.primary,
                                child: Icon(
                                  Icons.assignment,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                'Relatório Aviário ${relatorio.nrAviario}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4.0),
                                  Text('Turno: ${relatorio.turno}'),
                                  Text('Lote: ${relatorio.nrLote}'),
                                  Text('Aves Recebidas: ${relatorio.qtRecebidas}'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.arrow_forward_ios, size: 16.0),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Aqui você pode adicionar navegação para 
                                  // a tela de detalhes do relatório
                                },
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                // Aqui você pode adicionar navegação para 
                                // a tela de detalhes do relatório
                              },
                            ),
                          );
                        },
                      ),
              ),
              if (latestRelatorios.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, NamedRoute.relatorio);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Criar Novo Relatório',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

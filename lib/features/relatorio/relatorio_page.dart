import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../common/constants/app_colors.dart';
import '../../common/constants/app_text_styles.dart';
import '../../common/models/relatorio/relatorio_model.dart';
import '../../common/widgets/custom_floating_bottom_navbar.dart';
import '../../common/widgets/primary_button.dart';
import '../../services/relatorio_service/relatorio_service.dart';

class RelatorioPage extends StatefulWidget {
  final RelatorioModel? relatorioModelEdit;
  final RelatorioModel? relatorioModel;

  const RelatorioPage({super.key, this.relatorioModel, this.relatorioModelEdit});

  @override
  State<RelatorioPage> createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {
  final TextEditingController _turnoCtrl = TextEditingController();
  final TextEditingController _linhaCtrl = TextEditingController();
  final TextEditingController _nrAviarioCtrl = TextEditingController();
  final TextEditingController _qtRecebidasCtrl = TextEditingController();
  final TextEditingController _deathTransporteCtrl = TextEditingController();
  final TextEditingController _avesAbatidasCtrl = TextEditingController();
  final TextEditingController _codCondenaCtrl = TextEditingController();
  final TextEditingController _tpCondenaCtrl = TextEditingController();
  final TextEditingController _descCondenaCtrl = TextEditingController();
  final TextEditingController _qtDoencaCtrl = TextEditingController();
  final TextEditingController _nrLoteCtrl = TextEditingController();
  final TextEditingController _especifDoencasCtrl = TextEditingController();

  bool isCarregando = false;
  final RelatorioService _relatorioService = RelatorioService();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    if (widget.relatorioModelEdit != null) {
      _turnoCtrl.text = widget.relatorioModelEdit!.turno;
      _linhaCtrl.text = widget.relatorioModelEdit!.linha;
      _nrAviarioCtrl.text = widget.relatorioModelEdit!.nrAviario;
      _qtRecebidasCtrl.text = widget.relatorioModelEdit!.qtRecebidas;
      _deathTransporteCtrl.text = widget.relatorioModelEdit!.deathTransporte;
      _avesAbatidasCtrl.text = widget.relatorioModelEdit!.avesAbatidas;
      _codCondenaCtrl.text = widget.relatorioModelEdit!.codCondena;
      _tpCondenaCtrl.text = widget.relatorioModelEdit!.tpCondena;
      _descCondenaCtrl.text = widget.relatorioModelEdit!.descCondena;
      _qtDoencaCtrl.text = widget.relatorioModelEdit!.qtDoenca;
      _nrLoteCtrl.text = widget.relatorioModelEdit!.nrLote;
      _especifDoencasCtrl.text = widget.relatorioModelEdit!.especifDoencas;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.relatorioModelEdit != null ? 'Editar Relatório' : 'Novo Relatório',
          style: const TextStyle(color: AppColors.textDark),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textDark),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: isCarregando
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.0,
                    ),
                  )
                : const Icon(Icons.check, color: AppColors.primary),
            onPressed: sendClick,
          ),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informações Básicas',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: 16.0),
                    // Agrupando campos relacionados em Cards
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildFormField(
                              controller: _turnoCtrl,
                              label: 'Turno',
                              hint: 'Digite o turno',
                              icon: Icons.access_time,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _linhaCtrl,
                              label: 'Linha',
                              hint: 'Digite a linha',
                              icon: Icons.line_style,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _nrAviarioCtrl,
                              label: 'Número do Aviário',
                              hint: 'Digite o número do aviário',
                              icon: Icons.home_work,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8.0),
                    const Text(
                      'Dados Quantitativos',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: 16.0),
                    // Card para dados quantitativos
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildFormField(
                              controller: _qtRecebidasCtrl,
                              label: 'Quantidade Recebidas',
                              hint: 'Digite a quantidade recebida',
                              icon: Icons.add_box,
                              keyboardType: TextInputType.number,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _deathTransporteCtrl,
                              label: 'Mortes no Transporte',
                              hint: 'Digite o número de mortes',
                              icon: Icons.warning_amber,
                              keyboardType: TextInputType.number,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _avesAbatidasCtrl,
                              label: 'Aves Abatidas',
                              hint: 'Digite o número de aves abatidas',
                              icon: Icons.content_cut,
                              keyboardType: TextInputType.number,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8.0),
                    const Text(
                      'Informações de Condenação',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: 16.0),
                    // Card para informações de condenação
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildFormField(
                              controller: _codCondenaCtrl,
                              label: 'Código de Condenação',
                              hint: 'Digite o código de condenação',
                              icon: Icons.code,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _tpCondenaCtrl,
                              label: 'Tipo de Condenação',
                              hint: 'Digite o tipo de condenação',
                              icon: Icons.type_specimen,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _descCondenaCtrl,
                              label: 'Descrição da Condenação',
                              hint: 'Descreva a condenação',
                              icon: Icons.description,
                              maxLines: 2,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8.0),
                    const Text(
                      'Informações de Doenças',
                      style: AppTextStyles.subheading,
                    ),
                    const SizedBox(height: 16.0),
                    // Card para informações de doenças
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildFormField(
                              controller: _qtDoencaCtrl,
                              label: 'Quantidade de Doenças',
                              hint: 'Digite a quantidade de doenças',
                              icon: Icons.coronavirus,
                              keyboardType: TextInputType.number,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _nrLoteCtrl,
                              label: 'Número do Lote',
                              hint: 'Digite o número do lote',
                              icon: Icons.numbers,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                            const SizedBox(height: 16.0),
                            buildFormField(
                              controller: _especifDoencasCtrl,
                              label: 'Especificações das Doenças',
                              hint: 'Descreva as especificações das doenças',
                              icon: Icons.medical_information,
                              maxLines: 3,
                              validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16.0),
                    // Botão grande de salvar no final do formulário
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: 'Salvar Relatório',
                        onPressed: sendClick,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                  ],
                ),
              ),
            ),
          ),
          if (isCarregando)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomFloatingBottomNavbar(),
    );
  }
  
  // Método auxiliar para criar campos de formulário com estilo consistente
  Widget buildFormField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
      validator: validator,
    );
  }

  void sendClick() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    setState(() {
      isCarregando = true;
    });

    String id = widget.relatorioModelEdit != null
        ? widget.relatorioModelEdit!.id
        : const Uuid().v1();

    RelatorioModel relatorio = RelatorioModel(
      id: id,
      turno: _turnoCtrl.text,
      linha: _linhaCtrl.text,
      nrAviario: _nrAviarioCtrl.text,
      qtRecebidas: _qtRecebidasCtrl.text,
      deathTransporte: _deathTransporteCtrl.text,
      avesAbatidas: _avesAbatidasCtrl.text,
      codCondena: _codCondenaCtrl.text,
      tpCondena: _tpCondenaCtrl.text,
      descCondena: _descCondenaCtrl.text,
      qtDoenca: _qtDoencaCtrl.text,
      nrLote: _nrLoteCtrl.text,
      especifDoencas: _especifDoencasCtrl.text,
    );

    if (widget.relatorioModelEdit != null) {
      _relatorioService.addRelatorio(relatorio).then((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Relatório atualizado com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      }).catchError((error) {
        debugPrint("Erro ao atualizar o relatório: $error");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao atualizar o relatório'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            isCarregando = false;
          });
        }
      });
    } else {
      _relatorioService.addRelatorio(relatorio).then((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Relatório salvo com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      }).catchError((error) {
        debugPrint("Erro ao salvar relatório: $error");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro ao salvar o relatório'),
              backgroundColor: Colors.red,
            ),
          );
          setState(() {
            isCarregando = false;
          });
        }
      });
    }
  }
}

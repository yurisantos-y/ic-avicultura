import 'package:avicultura_app/common/models/relatorio/relatorio_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RelatorioService {
  String userId;
  RelatorioService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRelatorio(RelatorioModel relatorioModel) async {
    await _firestore
        .collection(userId)
        .doc(relatorioModel.id)
        .set(relatorioModel.toMap());
  }

  Future<List<RelatorioModel>> getLatestRelatorios({int limit = 3}) async {
    try {
      final querySnapshot = await _firestore
          .collection(userId)
          .orderBy('id', descending: true) // Assumindo que o ID tem timestamp
          .limit(limit)
          .get();
      
      return querySnapshot.docs
          .map((doc) => RelatorioModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Erro ao buscar relatórios: $e');
      return [];
    }
  }
}

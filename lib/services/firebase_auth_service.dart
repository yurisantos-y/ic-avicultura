import 'package:avicultura_app/common/models/user_model.dart';
import 'package:avicultura_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';

class FirebaseAuthService implements AuthService{
 final _auth = FirebaseAuth.instance;
  @override
  Future<UserModel> signIn({
    required String email,
    required String password
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if (result.user != null) {
        return UserModel(
            email: result.user!.email,
            id: result.user!.uid
        );
      } else {
        throw Exception("Usuário não encontrado");
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException ao fazer login: ${e.message}");
      if (e.code == 'network-request-failed') {
        throw "Erro de conexão. Verifique sua internet e tente novamente.";
      }
      throw e.message ?? "Erro ao fazer login";
    } on SocketException catch (_) {
      throw "Sem conexão com a internet. Verifique sua rede e tente novamente.";
    } catch (e) {
      debugPrint("Erro desconhecido ao fazer login: $e");
      throw "Erro ao fazer login. Tente novamente mais tarde.";
    }
  }

  @override
  Future<UserModel> signUp({
    required String email,
    required String password
  }) async {
    try {
      // Verificar conectividade tentando diretamente criar a conta
      // Removida a verificação fetchSignInMethodsForEmail que estava deprecada
      final result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).timeout(const Duration(seconds: 15));
      
      if (result.user != null) {
        await result.user!.updateDisplayName(email);
        return UserModel(
          email: result.user!.email,
          id: result.user!.uid
        );
      } else {
        throw "Falha ao criar conta";
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException ao criar conta: ${e.code} - ${e.message}");
      if (e.code == 'network-request-failed') {
        throw "Erro de conexão. Verifique sua internet e tente novamente.";
      } else if (e.code == 'email-already-in-use') {
        throw "Este e-mail já está em uso. Tente fazer login ou use outro e-mail.";
      } else if (e.code == 'weak-password') {
        throw "A senha é muito fraca. Use uma senha mais forte.";
      }
      throw e.message ?? "Erro ao criar conta";
    } on SocketException catch (_) {
      throw "Sem conexão com a internet. Verifique sua rede e tente novamente.";
    } on TimeoutException catch (_) {
      throw "Tempo de conexão esgotado. Verifique sua internet e tente novamente.";
    } catch (e) {
      debugPrint("Erro desconhecido ao criar conta: $e");
      throw "Erro ao criar conta. Tente novamente mais tarde.";
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint("Erro ao fazer logout: ${e.message}");
      throw "Erro ao sair da conta";
    } catch (e) {
      throw "Erro ao sair da conta";
    }
  }
}
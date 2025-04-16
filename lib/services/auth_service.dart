import 'package:avicultura_app/common/models/user_model.dart';

abstract class AuthService {
  Future<UserModel> signUp({
    required String email,
    required String password,
});

  Future<UserModel> signIn({
    required String email,
    required String password,
});

  Future<void> signOut();
}
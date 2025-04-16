import 'package:avicultura_app/features/sign_up/sign_up_state.dart';
import 'package:avicultura_app/services/auth_service.dart';
import 'package:avicultura_app/services/secure_storage.dart';
import 'package:flutter/cupertino.dart';

class SignUpController extends ChangeNotifier {
  final AuthService _service;
  final SecureStorage _secureStorage;

  SignUpController(
      this._service,
      this._secureStorage
      );

  SignUpState _state = SignUpStateInitial();

  // This property tells the UI to redirect to post-registration form
  bool redirectToPostRegistration = false;

  SignUpState get state => _state;

  void _changeState(SignUpState newState) {
    _state = newState;
    
    // Set the redirect flag for successful registration
    if (newState is SignUpStateSuccess) {
      redirectToPostRegistration = true;
    }
    
    notifyListeners();
  }

  Future<void> signUp( {
  required String email,
  required String password
  }) async {
    _changeState(SignUpStateLoading());

    try {
      final user = await _service.signUp(
          email: email,
          password: password
      );
      if (user.id != null) {
        await _secureStorage.write(
            key: "CURRENT_USER",
            value: user.toJson()
        );
        _changeState(SignUpStateSuccess());
      } else {
        throw Exception();
      }
    } catch (e) {
      _changeState(SignUpStateError(e.toString()));
    }
  }
}
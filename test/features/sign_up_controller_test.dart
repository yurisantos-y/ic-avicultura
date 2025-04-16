import 'package:avicultura_app/common/models/user_model.dart';
import 'package:avicultura_app/features/sign_up/sign_up_controller.dart';
import 'package:avicultura_app/features/sign_up/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_classes.dart';

void main() {
  late SignUpController signUpController;
  late MockSecureStorage mockSecureStorage;
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;

  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    mockSecureStorage = MockSecureStorage();
    signUpController = SignUpController(
      mockFirebaseAuthService,
      mockSecureStorage
    );
    user = UserModel(
        email: 'user@email.com',
        id: '1a2b3c4d5e'
    );
  });

  test('Tests Sign Up Controller Success State', () async {

    expect(signUpController.state, isInstanceOf<SignUpStateInitial>());

    when(() => mockSecureStorage.write(
        key: "CURRENT_USER",
      value: user.toJson()
    )).thenAnswer((_) async {});

    when(
          () => mockFirebaseAuthService.signUp(
          email: 'user@email.com',
          password: 'user@123'
      ),
    ).thenAnswer((_) async => UserModel(
        email: 'user@email.com',
        id: '1a2b3c4d5e'
    ));

    await signUpController.signUp(
        email: 'user@email.com',
        password: 'user@123'
    );
    expect(signUpController.state, isInstanceOf<SignUpStateSuccess>());
  });

  test('Tests Sign Up Controller Error State', () async {

    expect(signUpController.state, isInstanceOf<SignUpStateInitial>());

    when(() => mockSecureStorage.write(
        key: "CURRENT_USER",
        value: user.toJson()
    )).thenAnswer((_) async {});

    when(
          () => mockFirebaseAuthService.signUp(
          email: 'user@email.com',
          password: 'user@123'
      ),
    ).thenThrow(
      Exception(),
    );

    await signUpController.signUp(
        email: 'user@email.com',
        password: 'user@123'
    );
    expect(signUpController.state, isInstanceOf<SignUpStateError>());
  });
}
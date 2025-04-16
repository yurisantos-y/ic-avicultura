import 'package:avicultura_app/common/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/mock_classes.dart';


void main() {
  late MockFirebaseAuthService mockFirebaseAuthService;
  late UserModel user;
  setUp(() {
    mockFirebaseAuthService = MockFirebaseAuthService();
    user = UserModel(
        email: 'user@email.com',
        id: '1a2b3c4d5e'
    );
  });

  group(
    'Testsm sign up',
      () {
        test('Test sign up success', () async {
          when(
                () => mockFirebaseAuthService.signUp(
                email: 'user@email.com',
                password: 'user@123'
            ),
          ).thenAnswer((_) async => UserModel(
              email: 'user@email.com',
              id: '1a2b3c4d5e'
          ));

          final result = await mockFirebaseAuthService.signUp(
              email: 'user@email.com',
              password: 'user@123'
          );

          expect(
              result,
              user
          );
        });

        test('Test sign up failure', () async {
          when(
                () => mockFirebaseAuthService.signUp(
                email: 'user@email.com',
                password: 'user@123'
            ),
          ).thenThrow(
            Exception(),
          );

          expect(
                  () => mockFirebaseAuthService.signUp(
                  email: 'user@email.com',
                  password: 'user@123'
              ),
              throwsException
          );
        });
      }
  );


}
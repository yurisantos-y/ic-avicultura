import 'package:avicultura_app/features/sign_in/sign_in_controller.dart';
import 'package:avicultura_app/features/sign_up/sign_up_controller.dart';
import 'package:avicultura_app/features/splash/splash_controller.dart';
import 'package:avicultura_app/services/auth_service.dart';
import 'package:avicultura_app/services/firebase_auth_service.dart';
import 'package:avicultura_app/services/firestore_service.dart';
import 'package:avicultura_app/services/secure_storage.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependencies() {
  // Services
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());
  locator.registerLazySingleton<FirestoreService>(() => FirestoreService());

  // Controllers
  locator.registerFactory<SplashController>(
          () => SplashController(const SecureStorage()
      ));

  locator.registerFactory<SignInController>(
          () => SignInController(locator.get<AuthService>()));
  locator.registerFactory<SignUpController>(
          () => SignUpController(
          locator.get<AuthService>(),
          const SecureStorage()
      ));
}
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCaZwVUfW2JYr9ZlgXnI-4cjR9uatY4GkQ',
    appId: '1:403354366006:web:4202024afdfd586d6ca897',
    messagingSenderId: '403354366006',
    projectId: 'ic-avicultura-app-f8ffd',
    authDomain: 'ic-avicultura-app-f8ffd.firebaseapp.com',
    storageBucket: 'ic-avicultura-app-f8ffd.appspot.com',
    measurementId: 'G-F85EB1417P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNDMfo3aFCtAG0sYGY3dmVKsHfHYGWVJs',
    appId: '1:403354366006:android:cafb7a6acb9efb7c6ca897',
    messagingSenderId: '403354366006',
    projectId: 'ic-avicultura-app-f8ffd',
    storageBucket: 'ic-avicultura-app-f8ffd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHTvLi82Nbl_humIDqp5gNz7L15t-kAHU',
    appId: '1:403354366006:ios:81f605f1489519bb6ca897',
    messagingSenderId: '403354366006',
    projectId: 'ic-avicultura-app-f8ffd',
    storageBucket: 'ic-avicultura-app-f8ffd.appspot.com',
    iosBundleId: 'com.example.aviculturaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHTvLi82Nbl_humIDqp5gNz7L15t-kAHU',
    appId: '1:403354366006:ios:81f605f1489519bb6ca897',
    messagingSenderId: '403354366006',
    projectId: 'ic-avicultura-app-f8ffd',
    storageBucket: 'ic-avicultura-app-f8ffd.appspot.com',
    iosBundleId: 'com.example.aviculturaApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaZwVUfW2JYr9ZlgXnI-4cjR9uatY4GkQ',
    appId: '1:403354366006:web:9938ec71d2c8abea6ca897',
    messagingSenderId: '403354366006',
    projectId: 'ic-avicultura-app-f8ffd',
    authDomain: 'ic-avicultura-app-f8ffd.firebaseapp.com',
    storageBucket: 'ic-avicultura-app-f8ffd.appspot.com',
    measurementId: 'G-FDWEGCTXB8',
  );

}
// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyBtFNPsCK_ZbkHRFZFHf1ZUJebCOZ7OJM0',
    appId: '1:806110282711:web:ab99a54159025a68eb4192',
    messagingSenderId: '806110282711',
    projectId: 'tapyn-2ff68',
    authDomain: 'tapyn-2ff68.firebaseapp.com',
    storageBucket: 'tapyn-2ff68.appspot.com',
    measurementId: 'G-L715GYX4F8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEVI7rF0ISq-YUYlB5LdHviO34xz8I2qg',
    appId: '1:806110282711:android:d5ddd551ae91d387eb4192',
    messagingSenderId: '806110282711',
    projectId: 'tapyn-2ff68',
    storageBucket: 'tapyn-2ff68.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfXn3YTph8LCiiui3KPk-1M2SMRPOlgos',
    appId: '1:806110282711:ios:21d51dff50389470eb4192',
    messagingSenderId: '806110282711',
    projectId: 'tapyn-2ff68',
    storageBucket: 'tapyn-2ff68.appspot.com',
    iosBundleId: 'com.example.tapyn',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBfXn3YTph8LCiiui3KPk-1M2SMRPOlgos',
    appId: '1:806110282711:ios:21d51dff50389470eb4192',
    messagingSenderId: '806110282711',
    projectId: 'tapyn-2ff68',
    storageBucket: 'tapyn-2ff68.appspot.com',
    iosBundleId: 'com.example.tapyn',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBtFNPsCK_ZbkHRFZFHf1ZUJebCOZ7OJM0',
    appId: '1:806110282711:web:fdc3ac07b48321b8eb4192',
    messagingSenderId: '806110282711',
    projectId: 'tapyn-2ff68',
    authDomain: 'tapyn-2ff68.firebaseapp.com',
    storageBucket: 'tapyn-2ff68.appspot.com',
    measurementId: 'G-W1XHYN020Z',
  );
}

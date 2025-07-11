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
    apiKey: '',
    appId: '1:396490676726:web:917226c8c525bdbd800fd7',
    messagingSenderId: '396490676726',
    projectId: 'kashishfire',
    authDomain: 'kashishfire.firebaseapp.com',
    storageBucket: 'kashishfire.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:396490676726:android:dc5f5fd4601b2509800fd7',
    messagingSenderId: '396490676726',
    projectId: 'kashishfire',
    storageBucket: 'kashishfire.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:396490676726:ios:f95bc7d67333c9b0800fd7',
    messagingSenderId: '396490676726',
    projectId: 'kashishfire',
    storageBucket: 'kashishfire.firebasestorage.app',
    androidClientId: '396490676726-u42ffi8q5hqip7sa4kc3fdci3sn11qfh.apps.googleusercontent.com',
    iosClientId: '396490676726-s8g1r8i7smgtet0jl39008kac864ua0s.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '1:396490676726:ios:f95bc7d67333c9b0800fd7',
    messagingSenderId: '396490676726',
    projectId: 'kashishfire',
    storageBucket: 'kashishfire.firebasestorage.app',
    androidClientId: '396490676726-u42ffi8q5hqip7sa4kc3fdci3sn11qfh.apps.googleusercontent.com',
    iosClientId: '396490676726-s8g1r8i7smgtet0jl39008kac864ua0s.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '',
    appId: '1:396490676726:web:07174df1dd06d071800fd7',
    messagingSenderId: '396490676726',
    projectId: 'kashishfire',
    authDomain: 'kashishfire.firebaseapp.com',
    storageBucket: 'kashishfire.firebasestorage.app',
  );
}

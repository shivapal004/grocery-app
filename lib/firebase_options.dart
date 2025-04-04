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
    apiKey: 'AIzaSyAu2p3IA2tpHxzzp4HTZ6bjeeEwR0RiUOE',
    appId: '1:1030442737448:web:d18dbaf7802749f1c47a1d',
    messagingSenderId: '1030442737448',
    projectId: 'grocery-app-f72b8',
    authDomain: 'grocery-app-f72b8.firebaseapp.com',
    storageBucket: 'grocery-app-f72b8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0bZ2DN5nRVTF9p35-zJhOyN5SFNx33_Q',
    appId: '1:1030442737448:android:ae7eef28a9501642c47a1d',
    messagingSenderId: '1030442737448',
    projectId: 'grocery-app-f72b8',
    storageBucket: 'grocery-app-f72b8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBFagK0WFz-T1ZMKaDaRSLmF4s2lRmc3rU',
    appId: '1:1030442737448:ios:89aa353baf8eb49ec47a1d',
    messagingSenderId: '1030442737448',
    projectId: 'grocery-app-f72b8',
    storageBucket: 'grocery-app-f72b8.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBFagK0WFz-T1ZMKaDaRSLmF4s2lRmc3rU',
    appId: '1:1030442737448:ios:89aa353baf8eb49ec47a1d',
    messagingSenderId: '1030442737448',
    projectId: 'grocery-app-f72b8',
    storageBucket: 'grocery-app-f72b8.firebasestorage.app',
    iosBundleId: 'com.example.groceryApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAu2p3IA2tpHxzzp4HTZ6bjeeEwR0RiUOE',
    appId: '1:1030442737448:web:a0d724a065863556c47a1d',
    messagingSenderId: '1030442737448',
    projectId: 'grocery-app-f72b8',
    authDomain: 'grocery-app-f72b8.firebaseapp.com',
    storageBucket: 'grocery-app-f72b8.firebasestorage.app',
  );
}

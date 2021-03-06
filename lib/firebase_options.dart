// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD5bjmW93lECmZehsqtMCjI_Jr791xtwcM',
    appId: '1:845992066760:android:1196fbda9da6372fbf2ffd',
    messagingSenderId: '845992066760',
    projectId: 'movies-web-5330c',
    authDomain: 'movies-web-5330c.firebaseapp.com',
    databaseURL: 'https://movies-web-5330c-default-rtdb.firebaseio.com/',
    storageBucket: 'movies-web-5330c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD5bjmW93lECmZehsqtMCjI_Jr791xtwcM',
    appId: '1:845992066760:android:1196fbda9da6372fbf2ffd',
    messagingSenderId: '845992066760',
    projectId: 'movies-web-5330c',
    databaseURL: 'https://movies-web-5330c-default-rtdb.firebaseio.com/',
    storageBucket: 'movies-web-5330c.appspot.com',
  );
}

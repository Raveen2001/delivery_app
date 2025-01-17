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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBACluckSKhBjbmGsh56ZH2Okp1cUdc-3U',
    appId: '1:1058747735930:ios:7ed46ce391bc69706600c3',
    messagingSenderId: '1058747735930',
    projectId: 'delivery-app-a977e',
    storageBucket: 'delivery-app-a977e.firebasestorage.app',
    iosBundleId: 'in.raveen.deliveryApp',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAD1jbLAZvuZoT8UEmUJzfB5rj6V0vf8E8',
    appId: '1:1058747735930:android:e33da165ad0771a36600c3',
    messagingSenderId: '1058747735930',
    projectId: 'delivery-app-a977e',
    storageBucket: 'delivery-app-a977e.firebasestorage.app',
  );

}
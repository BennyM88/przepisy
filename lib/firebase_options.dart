// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, depend_on_referenced_packages
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCs3V_8gxn5rAJMjwyU0J6Q99dRxUe82rM',
    appId: '1:828810893904:android:f43e2ffda2d86e8efbcf55',
    messagingSenderId: '828810893904',
    projectId: 'przepisy-sylwii-project',
    storageBucket: 'przepisy-sylwii-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPFVtSQSNvNJlf6JTUhojHHX2iLNYMhAA',
    appId: '1:828810893904:ios:9519b34b0cfd42f7fbcf55',
    messagingSenderId: '828810893904',
    projectId: 'przepisy-sylwii-project',
    storageBucket: 'przepisy-sylwii-project.appspot.com',
    androidClientId:
        '828810893904-ggftnp73l7hrhkmj4cf345qngo3ccmgn.apps.googleusercontent.com',
    iosClientId:
        '828810893904-k8b8ut48o5ji58kcrfpn9o2s27jfpaeo.apps.googleusercontent.com',
    iosBundleId: 'com.example.przepisy',
  );
}
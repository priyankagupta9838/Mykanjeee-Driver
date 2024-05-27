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
    apiKey: 'AIzaSyDTBSKGa5dLbmws5CWJkZeNslms2Or1D_0',
    appId: '1:122310440737:web:7360d464208a683ac2b060',
    messagingSenderId: '122310440737',
    projectId: 'mykanjee-55ea0',
    authDomain: 'mykanjee-55ea0.firebaseapp.com',
    storageBucket: 'mykanjee-55ea0.appspot.com',
    measurementId: 'G-08XNERCTJN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCurx2pf3NXFbCIOj6ze6hZ-BmtfPaQc_c',
    appId: '1:122310440737:android:35ff2aa74252421ac2b060',
    messagingSenderId: '122310440737',
    projectId: 'mykanjee-55ea0',
    storageBucket: 'mykanjee-55ea0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD6ick7pAsXDXTxUbrHUfI2G4J97y10_w',
    appId: '1:122310440737:ios:ab2f781501194e54c2b060',
    messagingSenderId: '122310440737',
    projectId: 'mykanjee-55ea0',
    storageBucket: 'mykanjee-55ea0.appspot.com',
    iosClientId: '122310440737-serbq12iua5hr8b70l4hosfqaopo9iqs.apps.googleusercontent.com',
    iosBundleId: 'com.example.mykanjeedriver',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD6ick7pAsXDXTxUbrHUfI2G4J97y10_w',
    appId: '1:122310440737:ios:ab2f781501194e54c2b060',
    messagingSenderId: '122310440737',
    projectId: 'mykanjee-55ea0',
    storageBucket: 'mykanjee-55ea0.appspot.com',
    iosClientId: '122310440737-serbq12iua5hr8b70l4hosfqaopo9iqs.apps.googleusercontent.com',
    iosBundleId: 'com.example.mykanjeedriver',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCOXCMMWw8k4XPdWxKv_WJ0g1jhNXLj5Yc',
    appId: '1:122310440737:web:a2d355db88f5304cc2b060',
    messagingSenderId: '122310440737',
    projectId: 'mykanjee-55ea0',
    authDomain: 'mykanjee-55ea0.firebaseapp.com',
    storageBucket: 'mykanjee-55ea0.appspot.com',
    measurementId: 'G-RC64K5VRCQ',
  );
}
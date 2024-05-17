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
    apiKey: 'AIzaSyDD1ZwQ_HU5Ln7LD1db1hjGxNSrnn57uaM',
    appId: '1:960450873565:web:0ea6fea87e42d875963334',
    messagingSenderId: '960450873565',
    projectId: 'jbic-14cfd',
    authDomain: 'jbic-14cfd.firebaseapp.com',
    storageBucket: 'jbic-14cfd.appspot.com',
    measurementId: 'G-8ZSYJNS66Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8InVqjZ5rE0QCU9PQYSLvM5kEuRQ--to',
    appId: '1:960450873565:android:e69ba1497acf1b7c963334',
    messagingSenderId: '960450873565',
    projectId: 'jbic-14cfd',
    storageBucket: 'jbic-14cfd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsuuG_MPh_mHSZSo1Q1mH0ov2Pe5nd5Cc',
    appId: '1:960450873565:ios:79d8339b63653348963334',
    messagingSenderId: '960450873565',
    projectId: 'jbic-14cfd',
    storageBucket: 'jbic-14cfd.appspot.com',
    iosBundleId: 'com.example.jbicv2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsuuG_MPh_mHSZSo1Q1mH0ov2Pe5nd5Cc',
    appId: '1:960450873565:ios:79d8339b63653348963334',
    messagingSenderId: '960450873565',
    projectId: 'jbic-14cfd',
    storageBucket: 'jbic-14cfd.appspot.com',
    iosBundleId: 'com.example.jbicv2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDD1ZwQ_HU5Ln7LD1db1hjGxNSrnn57uaM',
    appId: '1:960450873565:web:77e2ff28a61f48a7963334',
    messagingSenderId: '960450873565',
    projectId: 'jbic-14cfd',
    authDomain: 'jbic-14cfd.firebaseapp.com',
    storageBucket: 'jbic-14cfd.appspot.com',
    measurementId: 'G-H826RTJCEB',
  );
}
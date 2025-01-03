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
    apiKey: 'AIzaSyBDPPXeDPMzW4OlY4suRVgr0RHc601Ib6A',
    appId: '1:510654992394:web:1ad419fad762a40bffcff3',
    messagingSenderId: '510654992394',
    projectId: 'bite-express-b3634',
    authDomain: 'bite-express-b3634.firebaseapp.com',
    databaseURL: 'https://bite-express-b3634-default-rtdb.firebaseio.com',
    storageBucket: 'bite-express-b3634.appspot.com',
    measurementId: 'G-JYYX1KNE5H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyApM1zNsqZK8E_-uWpy1De6JIlLa0poIw4',
    appId: '1:510654992394:android:0025946678d1b6a6ffcff3',
    messagingSenderId: '510654992394',
    projectId: 'bite-express-b3634',
    databaseURL: 'https://bite-express-b3634-default-rtdb.firebaseio.com',
    storageBucket: 'bite-express-b3634.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4Ok6GNnO4sVEZzrTVVdhrIp6w04w3rUg',
    appId: '1:510654992394:ios:16b35d2fd30e295bffcff3',
    messagingSenderId: '510654992394',
    projectId: 'bite-express-b3634',
    databaseURL: 'https://bite-express-b3634-default-rtdb.firebaseio.com',
    storageBucket: 'bite-express-b3634.appspot.com',
    iosBundleId: 'com.example.biteexpress',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA4Ok6GNnO4sVEZzrTVVdhrIp6w04w3rUg',
    appId: '1:510654992394:ios:16b35d2fd30e295bffcff3',
    messagingSenderId: '510654992394',
    projectId: 'bite-express-b3634',
    databaseURL: 'https://bite-express-b3634-default-rtdb.firebaseio.com',
    storageBucket: 'bite-express-b3634.appspot.com',
    iosBundleId: 'com.example.biteexpress',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBDPPXeDPMzW4OlY4suRVgr0RHc601Ib6A',
    appId: '1:510654992394:web:aac3bb10f828f11effcff3',
    messagingSenderId: '510654992394',
    projectId: 'bite-express-b3634',
    authDomain: 'bite-express-b3634.firebaseapp.com',
    databaseURL: 'https://bite-express-b3634-default-rtdb.firebaseio.com',
    storageBucket: 'bite-express-b3634.appspot.com',
    measurementId: 'G-MQR75J79LG',
  );

}
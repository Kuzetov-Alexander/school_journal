// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAyzwTibFx5rdSrTvw7aUk2_p8-Rh4vVUE',
    appId: '1:201990896589:web:94c13151f00f1412a72284',
    messagingSenderId: '201990896589',
    projectId: 'schooldiary-55bc7',
    authDomain: 'schooldiary-55bc7.firebaseapp.com',
    storageBucket: 'schooldiary-55bc7.appspot.com',
    measurementId: 'G-3RGD1WZYXN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIR_brZQC63p8yTwCAiwu1xotu1Jejc60',
    appId: '1:201990896589:android:263bdd5b43d5fcf3a72284',
    messagingSenderId: '201990896589',
    projectId: 'schooldiary-55bc7',
    storageBucket: 'schooldiary-55bc7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCTKHmzlUEnw1muMh-iz_9rNun6kESSEb4',
    appId: '1:201990896589:ios:f40eb4cb9303387ea72284',
    messagingSenderId: '201990896589',
    projectId: 'schooldiary-55bc7',
    storageBucket: 'schooldiary-55bc7.appspot.com',
    iosClientId: '201990896589-1ksr3q3s134e1i3cphh60cc0brrjqh00.apps.googleusercontent.com',
    iosBundleId: 'com.example.schoolJournal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCTKHmzlUEnw1muMh-iz_9rNun6kESSEb4',
    appId: '1:201990896589:ios:f40eb4cb9303387ea72284',
    messagingSenderId: '201990896589',
    projectId: 'schooldiary-55bc7',
    storageBucket: 'schooldiary-55bc7.appspot.com',
    iosClientId: '201990896589-1ksr3q3s134e1i3cphh60cc0brrjqh00.apps.googleusercontent.com',
    iosBundleId: 'com.example.schoolJournal',
  );
}
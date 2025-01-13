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
    apiKey: 'AIzaSyB7pVe8-OnqPI3Q5hf4Rrs2eQTTCKeCsw8',
    appId: '1:91234346264:web:8ce0cb764166b607366a6d',
    messagingSenderId: '91234346264',
    projectId: 'cahyaroom-3bfdb',
    authDomain: 'cahyaroom-3bfdb.firebaseapp.com',
    storageBucket: 'cahyaroom-3bfdb.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0RfjDpu56DsThY3dH2ln7Wxe2JECJ7B0',
    appId: '1:91234346264:android:2ae1bffb7f2df62b366a6d',
    messagingSenderId: '91234346264',
    projectId: 'cahyaroom-3bfdb',
    storageBucket: 'cahyaroom-3bfdb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOlTvbbvX61TaTkYsr0-QSjtZ63nf6yBo',
    appId: '1:91234346264:ios:c2e495ca806f51a9366a6d',
    messagingSenderId: '91234346264',
    projectId: 'cahyaroom-3bfdb',
    storageBucket: 'cahyaroom-3bfdb.firebasestorage.app',
    iosClientId: '91234346264-vdf49b336m4g5981mv9mpv10b20jvuvg.apps.googleusercontent.com',
    iosBundleId: 'com.cahyaroom.app.cahyaroom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOlTvbbvX61TaTkYsr0-QSjtZ63nf6yBo',
    appId: '1:91234346264:ios:c2e495ca806f51a9366a6d',
    messagingSenderId: '91234346264',
    projectId: 'cahyaroom-3bfdb',
    storageBucket: 'cahyaroom-3bfdb.firebasestorage.app',
    iosClientId: '91234346264-vdf49b336m4g5981mv9mpv10b20jvuvg.apps.googleusercontent.com',
    iosBundleId: 'com.cahyaroom.app.cahyaroom',
  );
}

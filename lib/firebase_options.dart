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
    apiKey: 'AIzaSyCzB0gnJtBizHrpz1rEnCr0tqAq5YmRh1Q',
    appId: '1:730322868622:android:807a8662d10cacc67d2cdf',
    messagingSenderId: '730322868622',
    projectId: 'alpha-project-ce3c9',
    storageBucket: 'alpha-project-ce3c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlYyevQc4X0nvjyWkkjmNoNLmy3x2ygf0',
    appId: '1:730322868622:ios:96d6868e145487837d2cdf',
    messagingSenderId: '730322868622',
    projectId: 'alpha-project-ce3c9',
    storageBucket: 'alpha-project-ce3c9.appspot.com',
    androidClientId: '730322868622-iqk93ulfbdhgj78ud33tq3v4ll5fjdrc.apps.googleusercontent.com',
    iosClientId: '730322868622-9vrulvbkshlfd1ohilsfu88s09cql0ns.apps.googleusercontent.com',
    iosBundleId: 'com.example.alphaV1',
  );
}

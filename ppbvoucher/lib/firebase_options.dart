import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDemoApiKeyWeb',
    appId: '1:000000000000:web:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ppbvoucher-demo',
    authDomain: 'ppbvoucher-demo.firebaseapp.com',
    storageBucket: 'ppbvoucher-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsWLn3HAsnEIavaPoe2Y-Ln_A3IawPPQk',
    appId: '1:538777370342:android:4e89f0d84ed77797f00527',
    messagingSenderId: '538777370342',
    projectId: 'cleanquest-608ff',
    storageBucket: 'cleanquest-608ff.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyiOS',
    appId: '1:000000000000:ios:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ppbvoucher-demo',
    storageBucket: 'ppbvoucher-demo.appspot.com',
    iosBundleId: 'com.example.ppbvoucher',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDemoApiKeyMacOS',
    appId: '1:000000000000:macos:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'ppbvoucher-demo',
    storageBucket: 'ppbvoucher-demo.appspot.com',
    iosBundleId: 'com.example.ppbvoucher',
  );
}
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey:
        "AIzaSyD9xAYrjZaREKqlBTXKfxnTEnIFQW7rVr0", // Znajdziesz w google-services.json
    appId:
        "1:780014972143:android:840e2da26654cf19813f1a", // Znajdziesz w google-services.json
    messagingSenderId: "780014972143", // Znajdziesz w google-services.json
    projectId: "fireexercise-6bf3b", // Znajdziesz w google-services.json
    storageBucket:
        "fireexercise-6bf3b.firebasestorage.app", // Znajdziesz w google-services.json
  );
}

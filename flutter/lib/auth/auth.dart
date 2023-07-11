import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthWrapper {

  static setUp() {
    if (kDebugMode) {
      FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } else {
      final auth = FirebaseAuth.instanceFor(app: Firebase.app());
      auth.setPersistence(Persistence.SESSION);
    }
  }

  static signInAnonymously() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    print('Signed in anonymously as uid ${userCredential.user?.uid}');
  }

  static String? getUid() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  static setDisplayName(String displayName) async {
    FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
  }

  static String? getDisplayName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '';
  }
}

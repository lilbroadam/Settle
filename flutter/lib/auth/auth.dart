import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthWrapper {

  // TODO pass as a command line argument
  static bool _useEmulator = true;

  static init() {
    if (!_useEmulator) {
      final auth = FirebaseAuth.instanceFor(app: Firebase.app());
      auth.setPersistence(Persistence.SESSION);
    } else {
      final auth = FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }
  }

  static signInAnonymously() async {
    final userCredential = await FirebaseAuth.instance.signInAnonymously();
    print('uid: $userCredential');
  }

  // TODO
  static getUid() async {
    print(await FirebaseAuth.instance.currentUser);
    throw UnimplementedError();
  }
}

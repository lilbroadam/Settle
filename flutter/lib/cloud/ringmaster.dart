import 'package:firebase_database/firebase_database.dart';
import 'package:settle/protos/settle_session.dart';
import 'package:flutter/foundation.dart';
import 'clerk.dart';

class Ringmaster {

  static late final DatabaseReference _settlesRef;

  static setUp() {
    if (kDebugMode) {
      FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    }

    _settlesRef = FirebaseDatabase.instance.ref('clerk/settles/');
  }

  // TODO undo sessionOptions nullability
  static Future<int?> createSettle(SessionType? type) async {
    int code = await Clerk.getNewCode();
    SessionType type = new SessionType(Type.custom, true);
    SettleSession session = new SettleSession(code, type);

    _settlesRef.child('/$code').set({
      'settle': session.encode()
    });

    // TODO handle if this is an offline write

    print('Created Settle with code $code');
    return code;
  }
}

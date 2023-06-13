import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:settle/cloud/ringmaster.dart';
import 'package:settle/protos/settle_session.dart';

class Clerk {

  static late final DatabaseReference _testRef;
  static late final DatabaseReference _clerkRef;
  static late final DatabaseReference _codesRef;
  static late final DatabaseReference _settlesRef;

  static setUp() {
    if (kDebugMode) {
      FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    }

    _testRef = FirebaseDatabase.instance.ref('test');
    _clerkRef = FirebaseDatabase.instance.ref('clerk');
    _codesRef = FirebaseDatabase.instance.ref('clerk/codes/');
    _settlesRef = FirebaseDatabase.instance.ref('clerk/settles/');
  }

  static void _initCodes() {
    _codesRef.push().set({
      'code': 1
    });
  }

  static Future<int> _getLatestCode() async {
    final latestCodeSnapshot =
        await _codesRef.orderByKey().limitToLast(1).get();
    if (latestCodeSnapshot.exists) {
      return (latestCodeSnapshot.children.first.value as Map)['code'];
    } else {
      _initCodes();
      return _getLatestCode();
    }
  }

  // TODO change to use /clerk/codes/nextCode counter
  static Future<int> getNewCode() async {
    final newCode = 1 + await _getLatestCode();
    _codesRef.push().set({
      'code': newCode
    });
    return newCode;
  }

  static void testWrite(k, v) {
    _testRef.set({ k: v });
  }
}
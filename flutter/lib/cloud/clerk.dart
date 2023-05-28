import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Clerk {

  static late final DatabaseReference _testRef;
  static late final DatabaseReference _clerkRef;
  static late final DatabaseReference _codesRef;

  static setUp() {
    if (kDebugMode) {
      FirebaseDatabase.instance.useDatabaseEmulator('localhost', 9000);
    }

    _testRef = FirebaseDatabase.instance.ref('test');
    _clerkRef = FirebaseDatabase.instance.ref('clerk');
    _codesRef = FirebaseDatabase.instance.ref('clerk/codes/');
  }

  static Future<int> _getLatestCode() async {
    final latestCodeSnapshot =
        await _codesRef.orderByKey().limitToLast(1).get();
    if (latestCodeSnapshot.exists) {
      return (latestCodeSnapshot.children.first.value as Map)['code'];
    }
    
    _initCodes();
    return _getLatestCode();
  }

  static void _initCodes() {
    DatabaseReference codesPushRef = _codesRef.push();
    codesPushRef.set({
      'code': 1
    });
  }

  // TODO make this atomic with TransactionResult
  static Future<int> createSettle() async {
    final newCode = 1 + await _getLatestCode();
    DatabaseReference codesPushRef = _codesRef.push();
    codesPushRef.set({
      'code': newCode
    });
    
    print('Created Settle with code $newCode');
    return newCode;
  }

  static void testWrite(k, v) {
    _testRef.set({ k: v });
  }
}
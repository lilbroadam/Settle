import 'package:settle/auth/auth.dart';

class SettleSession {

  late int _code;
  late SessionType _type;
  late SessionState _state;
  late User _hostUser;
  late List<User> _users;
  late List<Candidate> _candidates;
  late List<Vote> _votes;
  late int _creationTime;
  late int _completionTime;

  SettleSession(this._code, this._type) {
    String? uid = FirebaseAuthWrapper.getUid();
    String? name = FirebaseAuthWrapper.getDisplayName();
    if (uid == null || name == null) {
      throw Exception('Cannot create Settle: unable to fetch UID and name');
    }
    _hostUser = User(uid, name);

    _users = [_hostUser];
    _state = SessionState.lobby;
    _candidates = [];
    _votes = [];
    _creationTime = DateTime.now().millisecondsSinceEpoch;
    _completionTime = -1;
  }

  Map<dynamic, dynamic> encode() {
    Map<dynamic, dynamic> sessionMap = new Map<dynamic, dynamic>();
    sessionMap['code'] = _code;
    sessionMap['type'] = _type.encode();
    sessionMap['state'] = _state.index;
    sessionMap['hostUser'] = _hostUser.encode();
    sessionMap['users'] = _listEncode(_users);
    sessionMap['candidates'] = _listEncode(_candidates);
    sessionMap['votes'] = _listEncode(_votes);
    sessionMap['creationTime'] = _creationTime;
    sessionMap['completionTime'] = _completionTime;
    return sessionMap;
  }

  List<dynamic> _listEncode(List<dynamic> list) {
    if (list.isEmpty) {
      return list;
    }
    return list.map((x) => x.encode()).toList();
  }
}

enum Type { custom, movies, restaurants }
class SessionType {
  Type type;
  bool allowCustom;

  SessionType(this.type, this.allowCustom);

  Map<String, dynamic> encode() {
    var encoded = new Map<String, dynamic>();
    encoded['type'] = type.index;
    encoded['allowed_custom'] = allowCustom;
    return encoded;
  }
}

enum SessionState { lobby, settling, complete }

class User {
  String uid;
  String displayName;

  User(this.uid, this.displayName);

  Map<String, dynamic> encode() {
    var encoded = new Map<String, dynamic>();
    encoded['uid'] = uid;
    encoded['displayName'] = displayName;
    return encoded;
  }
}

class Candidate {
  String candidate;

  Candidate(this.candidate);
}

class Vote {
  // TODO
}
// import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:Settle/Server.dart';
import 'package:Settle/Settle.dart';
import 'package:Settle/CreateSettle.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Join user to server', () async {
    var hostName = "Adam";
    DefaultOptions option = DefaultOptions.movies;
    bool customAllowed = false;

    var settleCode = 
      await Server.createSettle(hostName, option, customAllowed);
    
    var guestName = "Adam 2";
    await Server.joinSettle(guestName, settleCode);

    Settle settleObject = await Server.getSettleInfo();
    List<String> users = settleObject.users;

    expect(users.length, 2);
    expect(users.contains(hostName), true);
    expect(users.contains(guestName), true);
  });
}
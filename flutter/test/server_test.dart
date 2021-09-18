// import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settle/cloud/settle_server/settle_server.dart';
import 'package:settle/protos/settle.dart';
import 'package:settle/screens/create_settle_screen.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   test('Join user to server', () async {
//     var hostName = "Adam";
//     DefaultOptions option = DefaultOptions.movies;
//     bool customAllowed = false;

//     var settleCode = await Server.createSettle(hostName, option, customAllowed);

//     var guestName = "Adam 2";
//     await Server.joinSettle(guestName, settleCode);

//     Settle settleObject = await Server.getSettleInfo();
//     List<String> users = settleObject.users;

//     expect(users.length, 2);
//     expect(users.contains(hostName), true);
//     expect(users.contains(guestName), true);
//   });
// }

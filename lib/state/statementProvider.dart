import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/Model/ministatement.dart';
import 'package:http/http.dart' as http;
import 'package:registration_practice/Model/token_response.dart';

// final statementListProvider = StateNotifierProvider((ref){
//   return StatementNotifier();
// });
final statementProviderList = StateNotifierProvider((ref) => StatementNotifier());
class StatementNotifier extends StateNotifier<List<Statement>>{

  static List<Statement> statements = [];
  StatementNotifier() : super(statements);
  // print('');
  // {
    Future<TokenResponse> logInToken() async {
      TokenResponse tokenResponse;

      print('System Viabilityt is expected');
      var url = 'https://billing.openpathsolutions.co.ke/oauth/token';
      var tokenMap = Map<String, dynamic>();
      tokenMap['grant_type'] = 'password';
      tokenMap['client_id'] = '2';
      tokenMap['client_secret'] = 'Rc2yRDYT1yomj8YVBxEiO7fIUVby2I5V1dgBWyCc';
      tokenMap['username'] = 'admin@localhost.com';
      tokenMap['password'] = '123456';

      var response = await http.post(
          url, body: tokenMap);

      if (response.statusCode == 200) {
        // print('Ok : token retrieved');
        tokenResponse = tokenResponseFromJson(response.body);
        print('Ok : token retrieved ${tokenResponse.accessToken}');
        // setEmail(email);
        // setPassword(password);
      }
      else {
        // Fluttertoast.showToast(msg: 'Invalid credentials, Please Check and Try Again');
        tokenResponse = null;
        print('Token not retrieved');
      }

      // globalTokenResponse = tokenResponse;
      return tokenResponse;
    }

    Future<List<Statement>> statementListDetails() async {
      List<Statement> statements = [];
      TokenResponse tokenResponse = await logInToken();
      if (tokenResponse != null) {
        var url = Uri.parse(
            'https://billing.openpathsolutions.co.ke/api/statement');

        var statementResponse = await http.get(
            url, headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${tokenResponse.accessToken}'
        });

        if (statementResponse.statusCode == 200) {
          // payments = paymentsModelFromJson(paymentResponse.body);
          statements = statementFromJson(statementResponse.body);
          // print('User is ${user.name} :: ${user.phoneNumber} :: ${user.balance} :: ${user.email} :: ${user.zone}');
        }
        else {
          statements = [];
          print('error : in retrieving the Payment history : ${statementResponse
              .statusCode}');
        }
      }
      else {
        statements = [];
      }
      print('Statements Lingth is ${statements.length}');
      state = statements;
      return statements;
    }
  // }
}
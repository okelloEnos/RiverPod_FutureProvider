import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/state/statementProvider.dart';
import 'package:registration_practice/Model/ministatement.dart';
import 'package:http/http.dart' as http;
import 'package:registration_practice/Model/token_response.dart';

void statementListProvider = StateNotifierProvider((ref){
  return StatementNotifier();
});

class DatatableScreen extends StatefulWidget {
  @override
  _DatatableState createState() => _DatatableState();
}

class _DatatableState extends State<DatatableScreen> {
var futureStatements;
List<Statement> listOfStatement = [];

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
  // state = statements;
  this.setState(() {
    listOfStatement = statements;
  });
  return statements;
}

  @override
  void initState() {
    // TODO: implement initState
    futureStatements = statementListDetails();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Test'),
      ),
      body:
      FutureBuilder(
          future: futureStatements,
          builder: (context, snapshot){
           if(snapshot.hasData){
             // return Text('What is Responsible ${snapshot.data.length}');
             return SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: SingleChildScrollView(
                 child: DataTable(columns: [
                   DataColumn(label: Text('Date')),
                   DataColumn(label: Text('Type')),
                   DataColumn(label: Text('Reference')),
                   DataColumn(label: Text('Credit')),
                   DataColumn(label: Text('Debit')),
                   DataColumn(label: Text('Running Balance'))
                 ], rows: 
                 // [
                 //  DataRow(cells: <DataCell>[
                 //    DataCell(Text('Okello')),
                 //    DataCell(Text('Enos')),
                 //    DataCell(Text('34km')),
                 //    DataCell(Text('Kes 540')),
                 //    DataCell(Text('Lupin')),
                 //  ])
                 // ]
                   listOfStatement.map((e) => DataRow(cells: <DataCell>[
                     DataCell(Text('${'Jun 30, 2019'}')),
                     DataCell(Text('${'Bill'}')),
                     DataCell(Text('${'Standing Order'}')),
                     DataCell(Text('${0.0}')),
                     DataCell(Text('${0.0}')),
                     DataCell(Text('${0.0}'))
                   ])).toList(),
                 ),
               ),
             );
           }
           else{
             return CircularProgressIndicator();
           }
          })
      // Consumer(builder: (context, watch, child){
      //   final listStatement = watch(statementProviderList.state);
      //   AsyncValue <List<Statement>> states = watch(statementProviderList.state);
      //   return Text('Your Statement ${listStatement.length}');
      // }),
    );
  }
}

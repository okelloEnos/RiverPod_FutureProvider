import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/state/statementProvider.dart';
import 'package:registration_practice/Model/ministatement.dart';
import 'package:http/http.dart' as http;
import 'package:registration_practice/Model/token_response.dart';

void statementListProvider = StateNotifierProvider((ref){
  return StatementNotifier();
});

class StatementDataSource extends DataTableSource{

  StatementDataSource({@required List<Statement> enosStatement, List<Statement> allTotal, int runnableBalance})
      : _statement = enosStatement, _allTotal = allTotal, _runnableBalance = runnableBalance, assert(enosStatement != null);
  final List<Statement> _statement ;
  List<Statement> _allTotal;
  int _runnableBalance;
  int selectedCount = 0;


  @override
  // TODO: implement rowCount
  int get rowCount => _statement.length;

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => selectedCount ;

  @override
  DataRow getRow(int index) {
    final Statement statement = _statement[index];

    print('Whats not Happening :: ${_statement.length}');
    if(_allTotal.isEmpty){
      if(statement.billType == 'Bill'){
        _runnableBalance =  statement.credit;
      }
      else{
        _runnableBalance = 0;
      }
    }
    else{
      if(statement.billType == 'Bill'){
        _runnableBalance = _runnableBalance + statement.credit;
        // for(var i in total){
        //   runningBalance = runningBalance + i.credit;
        // }
      }
      else{
        _runnableBalance = _runnableBalance - statement.debit;
        // for(var j in total){
        //   runningBalance = runningBalance - j.debit;
        // }
      }
    }

    _allTotal.add(statement);
    // TODO: implement getRow
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
      DataCell(Text('${'Jun 30, 2019'}')),
      DataCell(Text('${statement.billType}')),
      DataCell(Text('${statement.refNumber}')),
      DataCell(Text('${statement.credit}')),
      DataCell(Text('${statement.debit}')),
      DataCell(Text('$_runnableBalance'))
    ]);
  }
}
class DatatableScreen extends StatefulWidget {
  @override
  _DatatableState createState() => _DatatableState();
}

class _DatatableState extends State<DatatableScreen> {
var futureStatements;
List<Statement> listOfStatement = [];
final list = [];
var statementSource;
int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
List<Statement> total = [];
int runningBalance = 0;

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
    print('Just a Formality ${listOfStatement.length}');
    statementSource = StatementDataSource(enosStatement: listOfStatement);
    super.initState();
  }

   // = StatementDataSource(enosStatement: listOfStatement);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Table Test'),
      // ),
      body:
      SafeArea(
        child: FutureBuilder(
            future: futureStatements,
            builder: (context, snapshot){
             if(snapshot.hasData){
               print('${listOfStatement.length} ::What is the Status bas of Now ${snapshot.data.length}');
               statementSource = StatementDataSource(enosStatement: listOfStatement, allTotal: total, runnableBalance: runningBalance);
               // return Text('What is Responsible ${snapshot.data.length}');
               return snapshot.data.isEmpty ? Column(
                 children: [
                   SafeArea(
                     child: Padding(
                       padding: const EdgeInsets.all(20.0),
                       child: Column(
                         children: [
                           Container(
                             height: 30,
                             // color: Colors.teal,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 // Container(
                                 //   child: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
                                 // ),
                                 IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                                   Navigator.pop(context);
                                 }),
                                 SizedBox(width: 10,),
                                 Text('Statements', style: TextStyle(fontSize: 20),)
                               ],
                             ),

                           ),
                           SizedBox(height: 100),
                           Center(child: Text('No Statement at the Moment')),
                           // CircularProgressIndicator(),
                         ],
                       ),
                     ),
                   ),
                 ],
               ) : SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: SingleChildScrollView(
                   child: Container(
                     width: MediaQuery.of(context).size.width,
                     // height: 1000,
                     child: SingleChildScrollView(
                       child: PaginatedDataTable(
                         columnSpacing: 30,
                         onRowsPerPageChanged: (r){
                           print('Cool $r');
                           setState(() {
                             _rowsPerPage = r;
                           });
                         },
                         rowsPerPage: _rowsPerPage,
                         header: Container(
                           // color: Colors.teal,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               // Container(
                               //   child: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
                               // ),
                               IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                                 Navigator.pop(context);
                               }),
                               SizedBox(width: 10,),
                               Text('Statements', style: TextStyle(fontSize: 20),)
                             ],
                           ),
                         ),
                           source: statementSource,
                           columns: [
                         DataColumn(label: Text('Date')),
                         DataColumn(label: Text('Type')),
                         DataColumn(label: Text('Reference')),
                         DataColumn(label: Text('Credit')),
                         DataColumn(label: Text('Debit')),
                         DataColumn(label: Text('Running Balance'))
                       ],
                       ),
                     ),
                   ),
                 ),
               );
             }
             else{
               return SafeArea(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Column(
                     children: [
                       Container(
                         height: 30,
                         // color: Colors.teal,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             // Container(
                             //   child: IconButton(icon: Icon(Icons.arrow_back), onPressed: null),
                             // ),
                             IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                               Navigator.pop(context);
                             }),
                             SizedBox(width: 10,),
                             Text('Statements', style: TextStyle(fontSize: 20),)
                           ],
                         ),
                       ),
                       SizedBox(height: 100),
                       CircularProgressIndicator(),
                     ],
                   ),
                 ),
               );
             }
            }),
      )
      // Consumer(builder: (context, watch, child){
      //   final listStatement = watch(statementProviderList.state);
      //   AsyncValue <List<Statement>> states = watch(statementProviderList.state);
      //   return Text('Your Statement ${listStatement.length}');
      // }),
    );
  }
}

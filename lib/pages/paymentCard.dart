import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:subirah/model/User.dart';

class PaymentCard extends StatefulWidget {
  final String fName, lName, email, phoneNo, price;
  // final User retractUser;

  // final Function(String, String, int) onPressed;
  // final String phone;

  // const PaymentCard({Key key, this.onPressed, this.fName, this.lName, this.email, this.phoneNo, this.price}) : super(key: key);

  PaymentCard(
      {Key key,
      this.fName,
      this.lName,
      this.email,
       this.phoneNo,
       this.price,})
      : super(key: key);

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  TextEditingController _mmyy = TextEditingController();
  TextEditingController _cv = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print('first : ${widget.fName}  second: ${widget.email}');
    bool _error = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Color(0xFF009C9D),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60.0),
            Center(
                child:
                    Image(image: AssetImage('images/credit_card.png'))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0
                          // borderRadius: BorderRadius.only(
                          //   topRight: Radius.circular(30.0),
                          //   topLeft: Radius.circular(30.0),
                          ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Name      ${widget.fName} ${widget.lName}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Email       ${widget.email}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Phone      0${widget.phoneNo}',
                                style: TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0
                        // borderRadius: BorderRadius.only(
                        //   topRight: Radius.circular(30.0),
                        //   topLeft: Radius.circular(30.0),
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          Image(image: AssetImage('images/visa.png')),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            '4242',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            width: 60.0,
                            child: TextField(
                              style: TextStyle(color: Colors.black87),
                              controller: _mmyy,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  errorText: _error ? 'required' : null,
                                  labelText: 'MM/YY',
                                  labelStyle: TextStyle(color: Colors.black54),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black54))),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            width: 60.0,
                            child: TextField(
                              style: TextStyle(color: Colors.black87),
                              controller: _cv,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                  errorText: _error ? 'required' : null,
                                  labelText: 'CV',
                                  labelStyle: TextStyle(color: Colors.black54),),
                                  // focusedBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //         BorderSide(color: Colors.black)),
                                  // enabledBorder: UnderlineInputBorder(
                                  //     borderSide:
                                  //         BorderSide(color: Colors.black54))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: InkWell(
                    child: Container(
                      height: 50.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Pay   \$ 15',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    onTap: () async {
                     // SharedPreferences preferences = await SharedPreferences.getInstance();
                     // preferences.setBool('paid', true);
                     // bool register = preferences.setBool(option, true);
                     // String storedId = preferences.setString('Id', _id);
                     // widget.onPressed(_mmyy.text, _cv.text, 12);
                     // Navigator.of(context).pushReplacementNamed('welcome');
                     // Navigator.of(context).pushReplacementNamed('home', arguments: widget.retractUser);
                    },
                  ),
                )
              ],
            )
          ],
        ),
        // ],),
      ),
    );
  }
}

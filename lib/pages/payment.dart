import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  String _error;
  String _paymentClientSecret = 'sk_test_51ImDDeKYQg58bPLFTy479lLEr2PFK30KbKpSbHHsqVc0mAvy7bFKlflrL3wkBlGAcHXXo1FhGnAG62B9gwM9NDWB006iFjIfiz' ;
  PaymentIntentResult _intentResult;
  Source _source;
  ScrollController _scrollController = ScrollController();

  final CreditCard testCard = CreditCard(
    number: '4000002760003184',
    expMonth: 12,
    expYear: 21,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripePayment.setOptions(StripeOptions(publishableKey: 'pk_test_51ImDDeKYQg58bPLFmkb73xLHD2SHqMzUKh6m4pQXSg4DjslKNaWGV48i4k5QjQnFdH3mgcf4z0g8WEm3g2hT1pVp004ZIX2N4z',
    merchantId: 'Test', androidPayMode: 'test'));
  }

  void setError(dynamic error){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      _error = error.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title:Text('Flutter Pay PlugIn'),
      actions: [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _source = null;
              _intentResult = null;
              _paymentMethod = null;
              _paymentToken = null;
            });
          },
        )
      ],),
      body:
      ListView(
        controller: _scrollController,
        children: [
          // RaisedButton(
          //     child: Text('Create Source'),
          //     onPressed: (){
          //       StripePayment.createSourceWithParams(SourceParams(returnURL: 'http://okello', type: 'ideal',
          //       amount: 1099, currency: 'eur')).then((source) {
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received : ${source.sourceId}')));
          //         setState(() {
          //           _source = source;
          //         });
          //       }).catchError(setError);
          //     }),
          // Divider(),
          // RaisedButton(
          //     child: Text("Create Token with Card Form"),
          //     onPressed: (){
          //       StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest(
          //
          //       )).then((paymentMethod) {
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received :: ${paymentMethod.id}')));
          //         setState(() {
          //           _paymentMethod = paymentMethod;
          //         });
          //       }).catchError(setError);
          //     }),
          // RaisedButton(
          //     child: Text('Create Token with Card'),
          //     onPressed: (){
          //       StripePayment.createTokenWithCard(testCard).then((token){
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received : ${token.tokenId}')));
          //
          //         setState(() {
          //           _paymentToken = token;
          //         });
          //       }).catchError(setError);
          //     }),
          // Divider(),
          // RaisedButton(
          //     child: Text("Create Payment Method with Card"),
          //     onPressed: (){
          //       StripePayment.createPaymentMethod(PaymentMethodRequest(card: testCard)).then((paymentMethod){
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received :: ${paymentMethod.id}')));
          //         setState(() {
          //           _paymentMethod = paymentMethod;
          //         });
          //       }).catchError(setError);
          //     }),
          // RaisedButton(
          //     child: Text("Create Payment Method with existing token"),
          //     onPressed: _paymentToken == null ? null : (){
          //       StripePayment.createPaymentMethod(PaymentMethodRequest(
          //         card: CreditCard(
          //           token: _paymentToken.tokenId
          //         ),
          //       )).then((paymentMethod){
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received :: ${paymentMethod.id}')));
          //         setState(() {
          //           _paymentMethod = paymentMethod;
          //         });
          //       }).catchError(setError);
          //     }),
          // Divider(),
          // RaisedButton(
          //     child: Text("Confirm Payment Intent"),
          //     onPressed: _paymentMethod == null || _paymentClientSecret == null ? null :
          //     (){
          //       StripePayment.confirmPaymentIntent(PaymentIntent(clientSecret: _paymentClientSecret,
          //       paymentMethodId: _paymentMethod.id)).then((paymentIntent){
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received :: ${paymentIntent.paymentIntentId}')));
          //      setState(() {
          //        _intentResult = paymentIntent;
          //      });
          //       }).catchError(setError);
          //     }),
          // RaisedButton(
          //     child: Text(
          //       "Confirm Payment Intent with saving payment method",
          //       textAlign: TextAlign.center,
          //     ),
          //     onPressed: _paymentMethod == null || _paymentClientSecret == null
          //         ? null : (){
          //       StripePayment.confirmPaymentIntent(PaymentIntent(clientSecret: _paymentClientSecret, paymentMethodId: _paymentMethod.id,
          //       )).then((paymentIntent){
          //         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received :: ${paymentIntent.paymentIntentId}')));
          //         setState(() {
          //           _intentResult = paymentIntent;
          //         });
          //       }).catchError(setError);
          //     }),
          // RaisedButton(
          //   child: Text("Authenticate Payment Intent"),
          //   onPressed: _paymentClientSecret == null
          //       ? null
          //       : () {
          //     StripePayment.authenticatePaymentIntent(
          //         clientSecret: _paymentClientSecret)
          //         .then((paymentIntent) {
          //       _scaffoldKey.currentState.showSnackBar(SnackBar(
          //           content: Text(
          //               'Received ${paymentIntent.paymentIntentId}')));
          //       setState(() {
          //         _intentResult = paymentIntent;
          //       });
          //     }).catchError(setError);
          //   },
          // ),
          // Divider(),
          RaisedButton(
            child: Text("Native payment"),
            onPressed: () {
              if (Platform.isIOS) {
                _scrollController.jumpTo(450);
              }
              // StripePayment.
              StripePayment.paymentRequestWithNativePay(
                androidPayOptions: AndroidPayPaymentRequest(
                  totalPrice: "1.20",
                  currencyCode: "EUR",
                ),
                applePayOptions: ApplePayPaymentOptions(
                  countryCode: 'DE',
                  currencyCode: 'EUR',
                  items: [
                    ApplePayItem(
                      label: 'Test',
                      amount: '13',
                    )
                  ],
                ),
              ).then((token) {
                setState(() {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Received ${token.tokenId}')));
                  _paymentToken = token;
                });
              }).catchError(setError);
            },
          ),
          // RaisedButton(
          //   child: Text("Complete Native Payment"),
          //   onPressed: () {
          //     StripePayment.completeNativePayRequest().then((_) {
          //       _scaffoldKey.currentState.showSnackBar(
          //           SnackBar(content: Text('Completed successfully')));
          //     }).catchError(setError);
          //   },
          // ),
          // Divider(),
          // Text('Current source:'),
          // Text(
          //   JsonEncoder.withIndent('  ').convert(_source?.toJson() ?? {}),
          //   style: TextStyle(fontFamily: "Monospace"),
          // ),
          Divider(),
          Text('Current token:'),
          Text(
            JsonEncoder.withIndent('  ')
                .convert(_paymentToken?.toJson() ?? {}),
            style: TextStyle(fontFamily: "Monospace"),
          ),
          Divider(),
          // Text('Current payment method:'),
          // Text(
          //   JsonEncoder.withIndent('  ')
          //       .convert(_paymentMethod?.toJson() ?? {}),
          //   style: TextStyle(fontFamily: "Monospace"),
          // ),
          // Divider(),
          // Text('Current payment intent:'),
          // Text(
          //   JsonEncoder.withIndent('  ')
          //       .convert(_intentResult.toJson() ?? {}),
          //   style: TextStyle(fontFamily: "Monospace"),
          // ),
          Divider(),
          Text('Current error: $_error'),
        ],
      )
    );
  }
}

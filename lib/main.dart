import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/noInternet/internet_not_available.dart';
import 'package:registration_practice/pages/Home.dart';
import 'package:registration_practice/pages/Registration.dart';
import 'package:registration_practice/pages/TestConnection.dart';
import 'package:registration_practice/pages/ViewPhotos.dart';
import 'package:registration_practice/pages/check.dart';
import 'package:registration_practice/pages/datatable_screen.dart';
import 'package:registration_practice/pages/internet.dart';
import 'package:registration_practice/pages/payment.dart';
import 'package:registration_practice/pages/paymentCard.dart';
import 'package:registration_practice/pages/paymentView.dart';
import 'package:registration_practice/pages/webView.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/reg" : (context) => RegisterPage(),
        "/all" : (context) => AllPhotos(),
        "/pay" : (context) => Payment(),
        "/web" : (context) => WebViewLoad(),
        "/card" : (context) => PaymentCard(),
        "/load" : (context) => PaymentWeb(),
        "/net" : (context) => InternetChecker(),
        "/status" : (context) => CheckNetwork(),
        "/animation" : (context) => InternetNotAvailable(),
        "/ful" : (context) => SubConnection(),
        "/statement" : (context) => DatatableScreen()
      },
      theme: new ThemeData(
        primaryColor: Colors.amberAccent,
        // primaryColorLight: Colors.red,
        // primaryColorDark: Colors.black,
        accentColor: Colors.green
      ),
    ),
  ));
}


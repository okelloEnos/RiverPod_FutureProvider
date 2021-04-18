import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/pages/Home.dart';
import 'package:registration_practice/pages/Registration.dart';
import 'package:registration_practice/pages/ViewPhotos.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/reg" : (context) => RegisterPage(),
        "/all" : (context) => AllPhotos()
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


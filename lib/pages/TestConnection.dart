import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/pages/network_detector.dart';

class SubConnection extends StatefulWidget {
  @override
  _SubConnectionState createState() => _SubConnectionState();
}

class _SubConnectionState extends State<SubConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, watch, child){
            final checkCon = watch(networkAwareProvider.state);
            print('${checkCon.toString()}');
            return checkCon == NetworkStatus.Off ? Text('Net Imepotea') : Text('Hahahaaaaaa');
          },
        ),
      ),
    );
  }
}

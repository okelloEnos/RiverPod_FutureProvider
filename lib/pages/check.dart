import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/pages/network_detector.dart';

class CheckNetwork extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final network = useProvider(networkAwareProvider.state);

    return Scaffold(
      body: network == NetworkStatus.Off ? Center(child: Text('No Network')) : Center(child: Text('Net Iko')),
    );
  }
}

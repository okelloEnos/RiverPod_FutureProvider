import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { NotDetermined, On, Off }


// ignore: top_level_function_literal_block
final networkAwareProvider = StateNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  // ignore: close_sinks
  StreamController<ConnectivityResult> controller =
  StreamController<ConnectivityResult>();

  NetworkStatus lastResult;

  NetworkDetectorNotifier() : super(NetworkStatus.NotDetermined) {
    lastResult = NetworkStatus.NotDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      NetworkStatus newState;
      switch (result) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          newState = NetworkStatus.On;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.Off;

          break;
      }

      if (newState != state) {
        state = newState;
      }
    });
  }
}
import 'package:connectivity/connectivity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConnectivityStateNotifier extends StateNotifier{

  ConnectivityStateNotifier() : super('None'){
    Connectivity().onConnectivityChanged.listen((event) {
      print('Change has Occur');
      // isConnected = !isConnected;
      resultHandler(event);
    });
  }

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  String _svgUrl = 'images/visa.png';
  String _pageText = 'Currently connected to no network. Please connect to a wifi network!';
  bool isConnected = true;

  ConnectivityResult get connectivity => _connectivityResult;
  String get svgUrl => _svgUrl;
  String get pageDownText => _pageText;
  bool get connected => isConnected;

  void resultHandler(ConnectivityResult result){
    _connectivityResult = result;

    if(result == ConnectivityResult.none){
      isConnected = false;
      _svgUrl = 'images/visa.png';
      _pageText = 'Currently connected to no network. Please connect to a wifi network!';
    }
    else if(result == ConnectivityResult.mobile){
      isConnected = true;
      _svgUrl = 'images/visa.png';
      _pageText =
      'Currently connected to a celluar network. Please connect to a wifi network!';
    }
    else if(result == ConnectivityResult.wifi){
      isConnected = true;
      _svgUrl = 'images/visa.png';
      _pageText = 'Connected to a wifi network!';
    }
  }

  void initialLoad() async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    resultHandler(connectivityResult);
  }
}
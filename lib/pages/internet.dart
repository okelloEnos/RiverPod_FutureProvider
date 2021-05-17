import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/state/connection.dart';

final netProvider = StateNotifierProvider((ref) => ConnectivityStateNotifier());

class InternetChecker extends HookWidget {
  // bool isConnected = false;

  @override
  Widget build(BuildContext context) {

    final connectionProvider = useProvider(netProvider);
    final checkChange = useState(false);
    // connectionProvider.initialLoad();
    checkChange.value = connectionProvider.connected;
    print('ooooooooooooooooooo :: ${checkChange.value}');

    useEffect(() {
      print('effect Executed');
      connectionProvider.initialLoad();
    // model.fetchList();
    // showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       content: Text("hi"),
    //     ));
    // Container(
    //   height: 70,
    //   width: 200,
    //   color: Colors.red,
    // );
    return () => {};
    }, []);
    return Scaffold(
      body: Column(
        children: [
          Flexible(child: Image.asset(connectionProvider.svgUrl, fit: BoxFit.contain,),),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 100),
              child: Text(
                connectionProvider.pageDownText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          RaisedButton(
            color: Colors.deepOrange,
            onPressed: (){
              checkChange.value = connectionProvider.connected;
            },
            child: Text('Create Account'),),
        ],
      ),
    );
  }
}

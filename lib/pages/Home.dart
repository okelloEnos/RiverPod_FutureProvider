import 'package:flutter/material.dart';
import 'package:registration_practice/pages/Registration.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sunday"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(onPressed: (){
              Navigator.of(context).pushNamed('/all');
              // Navigator.maybePop(context);
              // Navigator.pop(context);
              // Navigator.canPop(context);
            },
            child: Text('Load Details'),),

          ],
        ),
      ),
      // RaisedButton(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
              heroTag: 'Add',
            ),
          ),
          FloatingActionButton(
            onPressed: (){
              print('Registration Page');
              // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              // Navigator.pushNamed(context, '/reg');
              Navigator.of(context).pushNamed('/reg');
              // Navigator.pushReplacement(context, newRoute)
              // Navigator.pushNamedAndRemoveUntil(context, newRouteName, (route) => false)
            },
            heroTag: 'Reg',
            tooltip: 'Register',
            child: Icon(Icons.next_plan_outlined),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

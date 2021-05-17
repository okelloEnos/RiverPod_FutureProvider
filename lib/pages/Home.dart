import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/pages/Registration.dart';
import 'package:registration_practice/state/photoProvider.dart';

class MyHomePage extends ConsumerWidget {

  void _incrementCounter() {
    print('Addition');
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final countProvider = useProvider(userSignUpState);
    var temp = watch(userSignUpState);
    print('Consumer ${temp.counterIncrement}');
    return Scaffold(
      appBar: AppBar(
        title: Text("Sunday"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 3.0)
                  ),
                  child: Image.asset('images/time.png')),
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                'lop ${temp.counterIncrement}',
                // '${countProvider.counterIncrement}',
                style: Theme.of(context).textTheme.headline4,
              ),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/all');
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
              child: Text('Load Details'),),
              RaisedButton(
                color: Colors.deepOrange,
                onPressed: (){
                  temp.setIsSignUp(true);
                Navigator.of(context).pushNamed('/reg');
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Create Account'),),
              RaisedButton(
                color: Colors.blue,
                onPressed: (){
                  temp.setIsSignUp(false);
                Navigator.of(context).pushNamed('/reg');
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Log In'),),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/status');
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Status'),),
              RaisedButton(
                color: Colors.lightGreenAccent,
                onPressed: (){
                  Navigator.of(context).pushNamed('/animation');
                  // Navigator.maybePop(context);
                  // Navigator.pop(context);
                  // Navigator.canPop(context);
                },
                child: Text('Animation'),),
              RaisedButton(
                color: Colors.pink,
                onPressed: (){
                  Navigator.of(context).pushNamed('/load');
                  // Navigator.maybePop(context);
                  // Navigator.pop(context);
                  // Navigator.canPop(context);
                },
                child: Text('Official View'),),
              RaisedButton(
                color: Colors.purple,
                  onPressed: (){
                Navigator.of(context).pushNamed('/web');
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Load Iframe'),),
              RaisedButton(onPressed: (){
                Navigator.of(context).pushNamed('/net');
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Internet'),),
            ],
          ),
        ),
      ),
      // RaisedButton(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: FloatingActionButton(
              onPressed: (){
                temp.setCount(temp.counterIncrement);
                // useState(
                //     countProvider.setCount(countProvider.counterIncrement);
                // );
                // countProvider.setCount(countProvider.counterIncrement);
              },
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

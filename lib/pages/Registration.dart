import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/state/photoProvider.dart';

class RegisterPage extends HookWidget{
bool isSignUp = false;
  @override
  Widget build(BuildContext context) {
    final auth = useProvider(userSignUpState);
    isSignUp = auth.isSignUp;

    return Scaffold(
      appBar: AppBar(
        title: isSignUp ? Text('Register') : Text('Log In'),
      ),
      body: SingleChildScrollView(
        child: isSignUp ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: Text('Create Account', style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),)),
            ),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration:
                InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E Mail Address'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number'
                ),
              ),
            ),
            Center(
              child: RaisedButton(onPressed: (){
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Register'),),
            ),
          ],
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0,),
            Center(
              child: Text('Welcome Back', style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
            ),
            SizedBox(height: 30.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number'
                ),
              ),
            ),
            Center(
              child: RaisedButton(onPressed: (){
                // Navigator.maybePop(context);
                // Navigator.pop(context);
                // Navigator.canPop(context);
              },
                child: Text('Log In'),),
            ),
          ],
        ),
      ),

    );
  }
}
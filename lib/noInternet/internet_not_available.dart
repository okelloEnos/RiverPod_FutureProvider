import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:registration_practice/noInternet/error_content.dart';
// import 'package:mgari_flutter/util/presentation/noInternet/error_content.dart';

class InternetNotAvailable extends HookWidget {
  const InternetNotAvailable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Duration duration = const Duration(seconds: 2);

    final animationController = useAnimationController(duration: duration);

    animationController
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();

    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return ErrorContent(
            controller: animationController,
          );
        },
      ),
    );
  }
}

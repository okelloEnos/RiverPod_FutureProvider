import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthenticationProvider extends StateNotifier{
  bool _isRegister;
  int _count = 0;

  AuthenticationProvider() : super(false);

  bool get isSignUp => _isRegister;

  void setIsSignUp(bool isSign){
    _isRegister = isSign;
  }

  int get counterIncrement => _count;

  void setCount(int value){
    print('Set counting  $value');
    _count = value + 1;
  }
}
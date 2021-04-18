import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:registration_practice/Model/photos.dart';
import 'package:registration_practice/networkRequest.dart';
import 'package:registration_practice/state/registrationProvider.dart';

final photoStateFuture = FutureProvider<List<Photos>>((ref) async {
  return fetchPhotos();
});

final userSignUpState = StateNotifierProvider((ref) => AuthenticationProvider());
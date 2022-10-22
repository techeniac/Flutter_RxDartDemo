import 'dart:ffi';

import 'package:flutterExample/rcs/manager/prefs_manager.dart';
import 'package:flutterExample/rcs/models/UserModel.dart';
import 'package:flutterExample/rcs/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc {
  final Repository _repository = Repository();
  final PrefsManager prefsManager = PrefsManager();

  PublishSubject<UserModel> signInController =
      PublishSubject<UserModel>();

  Stream<UserModel> get signUpStream => signInController.stream;

  Future<UserModel> signInWithEmailPhonePass(
      String email, String password) async {
    final UserModel response =
        await _repository.signInRepo(email, password);
    if (response.user != null) {
      await prefsManager.setUserId(response.user!.id!);
      await prefsManager.setUserData(response);
    }
    signInController.sink.add(response);
    return response;
  }

  void dispose() {
    signInController.close();

  }
}

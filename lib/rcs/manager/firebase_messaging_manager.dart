import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutterExample/rcs/manager/prefs_manager.dart';

class FirebaseMessagingManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final PrefsManager _prefsManager = PrefsManager();

  Future getToken() async {
    try {
      await _firebaseMessaging.getToken().then((token) {
        _prefsManager.setDeviceToken(token.toString());
        log(token.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }
}

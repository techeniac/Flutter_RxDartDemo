import 'dart:convert';
import 'package:flutterExample/rcs/models/UserModel.dart';
import 'package:flutterExample/rcs/utils/constant.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

class PrefsManager {
  Future setUserEmail(String userEmail) async {
    await prefs.setString(AppStrings.userEmail, userEmail);
  }

  String get userEmail => prefs.getString(AppStrings.userEmail)!;

  Future setDeviceToken(String token) async {
    await prefs.setString(AppStrings.deviceToken, token);
  }

  String get deviceToken => prefs.getString(AppStrings.deviceToken)!;

  Future setVerificationId(String verificationId) async {
    await prefs.setString(AppStrings.verificationID, verificationId);
  }

  String get otpVerificationId => prefs.getString(AppStrings.verificationID)!;

  Future setUserId(String userId) async {
    await prefs.setString(AppStrings.userId, userId);
  }

  int get userId => prefs.getInt(AppStrings.userId)!;

  Future setUserSignedIn(bool val) async {
    await prefs.setBool(AppStrings.isSignedIn, val);
  }

  bool get isSignedIn => prefs.getBool(AppStrings.isSignedIn) ?? false;

  Future setUserData(UserModel profileModel) async {
    await prefs.setString(
        AppStrings.userData, jsonEncode(profileModel.toJson()));
  }

  Future<UserModel?> getUserData() async {
    final String userDataVal = prefs.getString(AppStrings.userData) ?? '';
    if (userDataVal.isNotEmpty) {
      final Map<String, dynamic> json = jsonDecode(userDataVal);
      return UserModel.fromJson(json);
    } else {
      return null;
    }
  }

  Future prefsClear() async {
    final String? tempDeviceToken = prefs.getString(AppStrings.deviceToken);
    await prefs.remove(AppStrings.signIn);
    await prefs.clear();
    await prefs.setString(AppStrings.deviceToken, tempDeviceToken!);
  }
}

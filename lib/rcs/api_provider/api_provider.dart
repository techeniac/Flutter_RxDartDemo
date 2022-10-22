import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:flutterExample/rcs/manager/prefs_manager.dart';
import 'package:flutterExample/rcs/models/TestModel.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

import '../models/UserModel.dart';

class ApiProvider {
  final Client client = Client();
  final PrefsManager _prefsManager = PrefsManager();


  Future<UserModel> signInApiProvider(
      String email, String password) async {
    final response = await client.post(
        Uri.parse("${APIStrings.baseUrl}"+ "${APIStrings.login}"),
        body: json.encode({'email': email, 'password': password}),
        headers: {
          'content-type': 'application/json',
          // 'device_token': _prefsManager.deviceToken
        });

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      return UserModel.fromJson(json.decode(response.body));
    }
  }

  Future<List<TestModel>> getTestDataApiProvider() async {
    final response = await client.get(
        Uri.parse('${APIStrings.getTestImonial}'),
        headers: {'content-type': 'application/json'});

      debugPrint("$response");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<TestModel> testData = [];
      for (var item in data) {
        testData.add(TestModel.fromJson(item));
      }
      debugPrint("$testData");
      return testData;
    } else {
      return [TestModel.fromJson(json.decode(response.body))];
    }
  }

  // Future<MatchSchedulePlayersResponse> getMatchesPlayersApiProvider() async {
  //   final response = await client.get(
  //       Uri.parse('${APIStrings.baseUrl}${APIStrings.matchAndPlayersSchedule}'),
  //       headers: {'content-type': 'application/json'});
  //
  //   if (response.statusCode == 200) {
  //     return MatchSchedulePlayersResponse.fromJson(json.decode(response.body));
  //   } else {
  //     return MatchSchedulePlayersResponse.fromJson(json.decode(response.body));
  //   }
  // }

  // Future<ProfileResponse> getProfileByIdApiProvider(int id) async {
  //   final response = await client.get(
  //       Uri.parse('${APIStrings.baseUrl}${APIStrings.getProfile}$id'),
  //       headers: {'content-type': 'application/json'});
  //
  //   if (response.statusCode == 200) {
  //     return ProfileResponse.fromJson(json.decode(response.body));
  //   } else {
  //     return ProfileResponse.fromJson(json.decode(response.body));
  //   }
  // }
}

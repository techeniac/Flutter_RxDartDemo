import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/app.dart';
import 'package:flutterExample/rcs/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefsObject = await SharedPreferences.getInstance();
  prefs = prefsObject;
  runApp(const ExampleApp());
}

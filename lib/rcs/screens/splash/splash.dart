import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/screens/bottom_bar/bottom_navigation_bar.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () async {
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppBottomBar()),
        (route) => false,
      );
    });
    final width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.primaryColor),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.2),
          child: Image.asset('${AppStrings.pngPath}splash.png'),
        ),
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const Splash(
      ),
    );
  }
}
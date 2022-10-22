import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/bloc/bottom_bar_bloc.dart';
import 'package:flutterExample/rcs/manager/firebase_messaging_manager.dart';
import 'package:flutterExample/rcs/manager/prefs_manager.dart';
import 'package:flutterExample/rcs/screens/auth/sign_in.dart';
import 'package:flutterExample/rcs/screens/auth/sign_up.dart';
import 'package:flutterExample/rcs/screens/bottom_bar/tabs/home/home.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/constant.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({Key? key}) : super(key: key);
  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final FirebaseMessagingManager _messagingManager = FirebaseMessagingManager();
  final BottomBarBloc _bottomBarBloc = BottomBarBloc();
  late double height;
  late double width;
  final PrefsManager _prefsManager = PrefsManager();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future listenNotification() async {
    await _messagingManager.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("On app message recieved");
      log(message.notification!.title.toString());
      log(message.notification!.body.toString());
    });
    //background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Background mode notification');
      log(message.notification!.title.toString());
      log(message.notification!.body.toString());
    });
    //kill
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        log('Kill mode notification');
        log(message.notification!.title.toString());
        log(message.notification!.body.toString());
      }
    });
  }

  @override
  void initState() {
    listenNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  Widget get bottomNavigationBar => StreamBuilder<int>(
      initialData: 0,
      stream: _bottomBarBloc.currentIndexStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        return BottomNavigationBar(
            backgroundColor: AppColors.secondaryAccentColor,
            elevation: 4,
            iconSize: width * 0.06,
            unselectedFontSize: 12,
            selectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: AppStrings.homeBottom,
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.profile_circled),
                label: AppStrings.profileBottom,
              ),
            ],
            currentIndex: snapshot.data! == 4 || snapshot.data! == 5
                ? prefs.getInt(AppStrings.currentIndex) ?? 0
                : snapshot.data!,
            selectedItemColor: AppColors.red,
            unselectedItemColor: AppColors.black,
            onTap: (index) async {
              await prefs.setInt(AppStrings.currentIndex, index);
              await _bottomBarBloc.changeIndex(index);
            });
      });

  Widget get body => StreamBuilder<int>(
        initialData: 0,
        stream: _bottomBarBloc.currentIndexStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          final int index = snapshot.data ?? 0;
          return index == 0
              ? HomeTab(bottomBarBloc: _bottomBarBloc)
              : index == 1
                  ? SignInScreen(bottomBarBloc: _bottomBarBloc)
                              : index == 5
                                  ? SignUpScreen(bottomBarBloc: _bottomBarBloc)
                                  : const SizedBox();
        },
      );
}

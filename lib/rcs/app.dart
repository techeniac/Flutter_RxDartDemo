import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/screens/splash/splash.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

class ExampleApp extends MaterialApp {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget get home => const Splash();

  @override
  String get title => AppStrings.appTitle;

  @override
  ThemeData get theme => ThemeData(
    backgroundColor: Colors.red,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.secondaryColor,
          selectionColor: AppColors.secondaryColor,
          selectionHandleColor: AppColors.secondaryColor,
        ),
        fontFamily: AppStrings.poppinRegular,
        colorScheme: const ColorScheme.light(),
        primaryColor: AppColors.secondaryColor,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            textStyle: const TextStyle(
              fontFamily: AppStrings.poppinRegular,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppColors.secondaryColor,
            padding: const EdgeInsets.all(10),
            elevation: 5,
            textStyle: const TextStyle(
              fontSize: 16,
              fontFamily: AppStrings.poppinRegular,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: AppColors.secondaryColor,
            elevation: 5,
          ),
        ),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              buttonColor: AppColors.secondaryColor,
              padding: const EdgeInsets.all(10),
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        inputDecorationTheme: ThemeData.light().inputDecorationTheme.copyWith(
              contentPadding: const EdgeInsets.all(10),
              errorMaxLines: 3,
              fillColor: Colors.white,
              filled: true,
              hintStyle: const TextStyle(
                color: AppColors.gray,
                fontFamily: AppStrings.poppinRegular,
                fontSize: 14,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.gray,
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: AppColors.secondaryColor,
                  width: 1,
                ),
              ),
              errorStyle: const TextStyle(
                fontSize: 13,
                fontFamily: AppStrings.poppinRegular,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: ThemeData.light().textTheme.headline5!.copyWith(
                    fontFamily: AppStrings.poppinRegular,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryColor,
                  ),
              headline6: ThemeData.light().textTheme.headline5!.copyWith(
                    fontFamily: AppStrings.poppinRegular,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
              subtitle1: ThemeData.light().textTheme.subtitle1!.copyWith(
                    fontFamily: AppStrings.poppinRegular,
                    color: AppColors.black,
                  ),
              subtitle2: ThemeData.light().textTheme.subtitle2!.copyWith(
                    fontFamily: AppStrings.poppinRegular,
                    color: AppColors.black,
                  ),
              caption: ThemeData.light().textTheme.caption!.copyWith(
                    fontFamily: AppStrings.poppinRegular,
                    color: AppColors.black,
                  ),
              button: ThemeData.light().textTheme.button!.copyWith(
                    fontFamily: AppStrings.poppinRegular,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
              bodyText1: ThemeData.light().textTheme.bodyText1!.copyWith(
                    color: AppColors.black,
                    fontFamily: AppStrings.poppinLight,
                  ),
              bodyText2: ThemeData.light().textTheme.bodyText2!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppStrings.poppinRegular,
                  ),
            ),
      );

  // @override
  // Map<String, WidgetBuilder> get routes => {
  //       '/': (context) => const SignUpScreen(),
  //       AppStrings.signInRoute: (context) => const SignInScreen(),
  //       AppStrings.signUpRoute: (context) => const SignUpScreen(),
  //       AppStrings.bottomBarRoute: (context) => const AppBottomBar(),
  //       AppStrings.updatePassRoute: (context) => const UpdatePasswordScreen(),
  //     };

  @override
  bool get debugShowCheckedModeBanner => false;
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/api_provider/firebase_auth_provider.dart';
import 'package:flutterExample/rcs/bloc/bottom_bar_bloc.dart';
import 'package:flutterExample/rcs/bloc/sign_in_bloc.dart';
import 'package:flutterExample/rcs/manager/firebase_messaging_manager.dart';
import 'package:flutterExample/rcs/manager/prefs_manager.dart';
import 'package:flutterExample/rcs/screens/bottom_bar/bottom_navigation_bar.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';
import 'package:flutterExample/rcs/widgets/common_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key, required this.bottomBarBloc}) : super(key: key);
  final BottomBarBloc bottomBarBloc;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SignInBloc _signInBloc = SignInBloc();
  final PrefsManager _prefsManager = PrefsManager();
  final FirebaseMessagingManager _firebaseMessagingManager =
      FirebaseMessagingManager();
  final FirebaseAuthProvider _authProvider = FirebaseAuthProvider();

  late TextTheme _textTheme;
  late double width;
  late double height;
  late bool isVisible = false;

  @override
  void initState() {
    _firebaseMessagingManager.getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    _textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onPanDown: (_) => FocusScope.of(context).unfocus(),
      child: body,
    );
  }

  Widget get body => Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: height / 10),
                    AppLogoWithName(size: width * 0.3),
                    Center(
                      child: Text(
                        AppStrings.loginNow,
                        style: _textTheme.bodyText2!.copyWith(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRoundedTextfield(
                      controller: _emailController,
                      hintText: AppStrings.enterEmailHint,
                      validator: (val) => val == null || val.isEmpty
                          ? AppStrings.emailErrorText
                          : !EmailValidator.validate(val)
                              ? AppStrings.emailValidErrorText
                              : null,
                    ),
                    const SizedBox(height: 15),
                    CommonRoundedTextfield(
                      controller: _passwordController,
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => isVisible = !isVisible),
                        icon: Icon(
                          isVisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          size: width * 0.04,
                          color: AppColors.gray.withOpacity(0.7),
                        ),
                      ),
                      obscureText: !isVisible,
                      hintText: AppStrings.enterPasswordHint,
                      validator: (val) => val == null || val.isEmpty
                          ? AppStrings.passwordErrorText
                          : null,
                    ),
                    SizedBox(height: height * 0.04),
                    CommonButton(
                      text: AppStrings.signIn,
                      onPressed: () async => await onSignIn(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.notaMember,
                        style: _textTheme.bodyText2!
                            .copyWith(color: AppColors.black),
                      ),
                      TextSpan(
                        text: AppStrings.signUp,
                        style: _textTheme.bodyText2!.copyWith(
                          color: AppColors.secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => widget.bottomBarBloc.changeIndex(5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future onSignIn() async {
    // if (_formKey.currentState!.validate()) {
    //   CircularLoader().show(context);
    //   _signInBloc
    //       .signInWithEmailPhonePass(
    //           _emailController.text, _passwordController.text)
    //       .then((response) async {
    //     if (response.status) {
    //       if (response.result!.user.isVerified == 0) {
    //         await _authProvider
    //             .signInWithEmailPassword(
    //                 response.result!.user.email, _passwordController.text)
    //             .then((firebaseResponse) async {
    //           if (firebaseResponse.status) {
    //             await _authProvider
    //                 .isverified(firebaseResponse.result)
    //                 .then((emailVerificationResponse) async {
    //               if (emailVerificationResponse.status &&
    //                   emailVerificationResponse.code == 200) {
    //                 await _signInBloc
    //                     .userVerification(response.result!.user.email, 1)
    //                     .then((userVerificationResponse) {
    //                   if (userVerificationResponse.status) {
    //                     ScaffoldSnakBar()
    //                         .show(context, msg: 'Sign-In Successfully');
    //                     _prefsManager.setuserSignedIn(true);
    //                     Navigator.pushAndRemoveUntil(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => const AppBottomBar()),
    //                         (route) => false);
    //                   } else {
    //                     CircularLoader().hide(context);
    //                     ScaffoldSnakBar().show(context,
    //                         msg: userVerificationResponse.message);
    //                   }
    //                 });
    //               } else if (emailVerificationResponse.status &&
    //                   emailVerificationResponse.code == 404) {
    //                 CircularLoader().hide(context);
    //                 ScaffoldSnakBar()
    //                     .show(context, msg: emailVerificationResponse.message);
    //               } else {
    //                 CircularLoader().hide(context);
    //                 ScaffoldSnakBar()
    //                     .show(context, msg: emailVerificationResponse.message);
    //               }
    //             });
    //           } else {
    //             CircularLoader().hide(context);
    //             ScaffoldSnakBar().show(context, msg: firebaseResponse.message);
    //           }
    //         });
    //       } else {
    //         CircularLoader().hide(context);
    //         ScaffoldSnakBar().show(context, msg: response.message);
    //         _prefsManager.setuserSignedIn(true);
    //         Navigator.pushAndRemoveUntil(
    //             context,
    //             MaterialPageRoute(builder: (context) => const AppBottomBar()),
    //             (route) => false);
    //       }
    //     } else {
    //       CircularLoader().hide(context);
    //       ScaffoldSnakBar().show(context, msg: response.message);
    //     }
    //   });
    // }

        _signInBloc
            .signInWithEmailPhonePass(
                _emailController.text, _passwordController.text)
            .then((response) async {

    if (_formKey.currentState!.validate()) {
      ScaffoldSnakBar()
          .show(context, msg: 'Sign-In Successfully');
      _prefsManager.setUserSignedIn(true);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const AppBottomBar()),
              (route) => false);
    }else{
            CircularLoader().hide(context);
            ScaffoldSnakBar().show(context, msg: "Wrong Username Password");
    }});
  }
}

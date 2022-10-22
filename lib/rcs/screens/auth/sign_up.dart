import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/bloc/bottom_bar_bloc.dart';

import 'package:flutterExample/rcs/manager/firebase_messaging_manager.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';
import 'package:flutterExample/rcs/widgets/common_widget.dart';

import '../../manager/prefs_manager.dart';
import '../../models/UserModel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.bottomBarBloc}) : super(key: key);
  final BottomBarBloc bottomBarBloc;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final PrefsManager prefsManager = PrefsManager();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseMessagingManager _firebaseMessagingManager =
      FirebaseMessagingManager();
  late TextTheme _textTheme;
  late double width;
  late double height;
  late bool isPassVisible = false;
  late bool isConfPassVisible = false;

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
                    SizedBox(height: height / 15),
                    AppLogoWithName(size: width * 0.3),
                    Center(
                      child: Text(
                        AppStrings.signUpNow,
                        style: _textTheme.bodyText2!.copyWith(
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    CommonRoundedTextfield(
                      controller: _firstNameController,
                      hintText: AppStrings.enterFirstNameHint,
                      validator: (val) => val == null || val.trim().isEmpty
                          ? AppStrings.firstNameErrorText
                          : null,
                    ),
                    const SizedBox(height: 15),
                    CommonRoundedTextfield(
                      controller: _lastNameController,
                      hintText: AppStrings.enterLastNameHint,
                      validator: (val) => val == null || val.trim().isEmpty
                          ? AppStrings.lastNameErrorText
                          : null,
                    ),
                    const SizedBox(height: 15),
                    CommonRoundedTextfield(
                      controller: _emailController,
                      hintText: AppStrings.enterEmailHint,
                      validator: (val) => val == null ||
                              val.trim().isEmpty ||
                              !EmailValidator.validate(val)
                          ? AppStrings.emailValidErrorText
                          : null,
                    ),
                    const SizedBox(height: 15),
                    CommonRoundedTextfield(
                      controller: _passwordController,
                      suffixIcon: IconButton(
                        onPressed: () =>
                            setState(() => isPassVisible = !isPassVisible),
                        icon: Icon(
                          isPassVisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          size: width * 0.04,
                          color: AppColors.gray.withOpacity(0.7),
                        ),
                      ),
                      obscureText: !isPassVisible,
                      hintText: AppStrings.enterPasswordHint,
                      validator: (val) => val == null || val.isEmpty
                          ? AppStrings.passwordErrorText
                          : null,
                    ),
                    const SizedBox(height: 15),
                    CommonRoundedTextfield(
                      controller: _confirmPasswordController,
                      suffixIcon: IconButton(
                        onPressed: () => setState(
                            () => isConfPassVisible = !isConfPassVisible),
                        icon: Icon(
                          isConfPassVisible
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          size: width * 0.04,
                          color: AppColors.gray.withOpacity(0.7),
                        ),
                      ),
                      obscureText: !isConfPassVisible,
                      hintText: AppStrings.enterConfirmPasswordHint,
                      validator: (val) => val == null ||
                              val.isEmpty ||
                              val != _passwordController.text
                          ? AppStrings.confirmPasswordErrorText
                          : null,
                    ),
                    SizedBox(height: height * 0.03),
                    CommonButton(
                      text: AppStrings.createAccount,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final User userModel = User(

                            name: _firstNameController.text.trim(),
                            email: _emailController.text,
                            );

                          await onSignUp(userModel);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.alreadyaMember,
                        style: _textTheme.bodyText2!
                            .copyWith(color: AppColors.black),
                      ),
                      TextSpan(
                        text: AppStrings.signIn,
                        style: _textTheme.bodyText2!.copyWith(
                          color: AppColors.secondaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => widget.bottomBarBloc.changeIndex(1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Future onSignUp(User userModel) async {
    await prefsManager.setUserData(UserModel(user: userModel,tokens: null));

    ScaffoldSnakBar().show(context,
        msg:
        'Congratulation ${userModel.name}, You can login with test user! 😂');

  }
}

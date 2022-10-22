import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:flutterExample/rcs/utils/strings.dart';

class AppLogoWithName extends StatelessWidget {
  const AppLogoWithName({Key? key, required this.size}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '${AppStrings.pngPath}splash.png',
      height: size,
      width: size,
    );
  }
}

class CommonRoundedTextfield extends StatelessWidget {
  const CommonRoundedTextfield({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.onChanged,
    this.maxLength,
    this.fillColor,
    this.inputFormatters,
    this.onTap,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textAlignCenter = true,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final int? maxLength;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? textAlignCenter;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      readOnly: readOnly,
      maxLength: maxLength,
      style: theme.textTheme.bodyText1,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      textCapitalization: textCapitalization,
      cursorColor: AppColors.black,
      decoration: inputRoundedDecoration(
        fillColor: fillColor,
        getHint: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}

InputDecoration inputRoundedDecoration(
    {required String getHint,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    bool isDropDown = false}) {
  return InputDecoration(
    hintText: getHint,
    hintStyle: TextStyle(
      color: AppColors.gray.withOpacity(0.7),
      fontFamily: AppStrings.poppinLight,
    ),
    filled: true,
    fillColor: fillColor ?? AppColors.black.withOpacity(0.1),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.only(left: 15.0),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: AppColors.gray, width: 1),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: AppColors.red, width: 1),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: AppColors.yellow, width: 1),
    ),
  );
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    Key? key,
    required this.text,
    this.color = AppColors.secondaryColor,
    this.fontSize = 14,
    this.icon,
    required this.onPressed,
    this.fontColor = AppColors.black,
    this.elevation = 3,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color fontColor;
  final double fontSize;
  final IconData? icon;
  final void Function() onPressed;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: fontColor,
                    fontFamily: AppStrings.poppinRegular,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            icon != null
                ? Icon(
                    icon,
                    color: fontColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${(clockTimer.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: Theme.of(context)
          .textTheme
          .bodyText2!
          .copyWith(color: AppColors.yellow, fontSize: 16),
    );
  }
}

class CircularLoader {
  void show(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: height,
          width: width,
          color: AppColors.primaryColor.withOpacity(0.2),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryAccentColor,
            ),
          ),
        );
      },
    );
  }

  void hide(BuildContext context) {
    return Navigator.of(context).pop();
  }
}

class BuilderLoader extends StatelessWidget {
  const BuilderLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.secondaryAccentColor,
        strokeWidth: 1.5,
      ),
    );
  }
}

class ScaffoldSnakBar {
  Future show(BuildContext context, {required String msg}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

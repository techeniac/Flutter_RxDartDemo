import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterExample/rcs/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InAppWebView extends StatefulWidget {
  const InAppWebView({Key? key, required this.appBarName, required this.url})
      : super(key: key);
  final String url;
  final String appBarName;
  @override
  InAppWebViewState createState() => InAppWebViewState();
}

class InAppWebViewState extends State<InAppWebView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.appBarName,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: AppColors.black,
                fontSize: 20,
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.black,
          ),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

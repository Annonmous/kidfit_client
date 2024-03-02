import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../components/custom_appbar.dart';
import '../../../constant/constants.dart';
import '../../../constant/navigation.dart';
import '../../../constant/theme.dart';


class BrowserScreen extends StatefulWidget {
  const BrowserScreen({super.key, required this.url, this.backEvent});
  final String url;
  final Function()? backEvent;
  @override
  State<BrowserScreen> createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  String title = "Loading";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeHelper>(builder: (themecontroller) {
      return AnnotatedRegion(
        value: themecontroller.systemUiOverlayStyleMain,
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: () async {
            widget.backEvent; 
              
            return true;
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: themecontroller.backgoundcolor,
              appBar:CustomAppBar(Title: 'Checkout', showShop: false),
              // PreferredSize(
              //   preferredSize: Size(size.width, 50),
              //   child:
              //   CustomAppbar(
              //     PageName: widget.titles,
              //     color: Colors.white,
              //     BackIconcolor: Colors.black,
              //     titlecolor: Colors.black,
              //     Visible_sidebar: false,
              //     Visible_bellIcon: false,
              //     backEvent: widget.backEvent ??
              //         () {
              //           // Navigation.getInstance
              //           //     .Page_PushAndReplaceNavigation(context, HomeScreen());
              //         },
              //   ),
              // ),
              body: WebView(
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onPageFinished: (url) async {
                  final String? title =
                      await (await _controller.future).getTitle();
                  setState(() {
                    this.title = title ?? "Untitled";
                  });
                  print(title);
                },
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
              ),
            ),
          ),
        ),
      );
    });
  }
}
import 'package:flutter/material.dart';
import 'package:salama_users/app/utils/logger.dart';
import 'package:salama_users/core/alerts/flushbar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

class CustomWebView extends StatefulWidget {
  final String authorizationUrl;

  const CustomWebView({
    super.key,
    required this.authorizationUrl,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomWebViewState createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // await DefaultCacheManager().emptyCache();
    _initializeWebViewController();
  }

  void _initializeWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            logger.e(url);
            final Uri uri = Uri.parse(url);
            // ignore: deprecated_member_use
            logger.wtf(uri.path);
            if (uri.path ==
                'https://100.25.177.226/taxi/subscriptions/paystack') {
              AppFlushbar.show('Payment is successful!');
              Navigator.pop(context);
            }
          },
          onNavigationRequest: (NavigationRequest request) async {
            logger.e(request.url);
            final Uri uri = Uri.parse(request.url);
            // ignore: deprecated_member_use
            logger.wtf(uri.path);
            if (uri.path == '/taxi/subscriptions/paystack') {
              Navigator.pop(context);
              showAlert(context);
              await FlutterPlatformAlert.playAlertSound();

              await FlutterPlatformAlert.showCustomAlert(
                windowTitle: 'This is title',
                text: 'This is body',
                positiveButtonTitle: "Positive",
                negativeButtonTitle: "Negative",
                neutralButtonTitle: "Neutral",
              );
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 8.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36')
      ..loadRequest(Uri.parse(
        widget.authorizationUrl.toString(),
      ));
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Payment Status",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.blueAccent, // You can customize the color
          ),
        ),
        content: Text(
          "Payment is Successful!",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
              // You can perform other actions here if needed
            },
            child: Text(
              "OK",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}

// class PaystackWebView extends StatefulWidget {
//   final String authorizationUrl;

//   const PaystackWebView({required this.authorizationUrl});

//   @override
//   _PaystackWebViewState createState() => _PaystackWebViewState();
// }

// class _PaystackWebViewState extends State<PaystackWebView> {
//   late WebViewController _webViewController;
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paystack Payment'),
//       ),
//       body: Stack(
//         children: [
//           WebView(
//             initialUrl: widget.authorizationUrl,
//             onWebViewCreated: (controller) {
//               _webViewController = controller;
//             },
//             onPageStarted: (String url) {
//               print('Page started loading: $url');
//               // Check if the URL matches the one we are waiting for
//               if (url.startsWith("https://100.25.177.226/taxi/subscriptions/paystack")) {
//                 // Extract trxref and reference if needed
//                 Uri uri = Uri.parse(url);
//                 String? trxref = uri.queryParameters['trxref'];
//                 String? reference = uri.queryParameters['reference'];
//                 print('Transaction ref: $trxref, Reference: $reference');

//                 // Pop the WebView and return the reference
//                 Navigator.pop(context, reference); // You can return any data from the pop
//               }
//             },
//             onPageFinished: (String url) {
//               print('Page finished loading: $url');
//               setState(() {
//                 isLoading = false;
//               });
//             },
//           ),
//           isLoading ? Center(child: CircularProgressIndicator()) : Container(),
//         ],
//       ),
//     );
//   }
// }

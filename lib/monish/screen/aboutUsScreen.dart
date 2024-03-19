import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../api/call_api.dart';
import '../../components/appbarComp.dart';

// final Uri AboutUs =
// Uri.parse('http://3.92.109.164/unique-tags/about.html');
// Future<void> _launchUrl(url) async {
//   if (!await launch("http://3.92.109.164/unique-tags/about.html")) {
//     throw 'Could not launch $Aboutus';
//   }
// }

class Aboutus extends StatefulWidget {
  int webViewType;
  Aboutus({Key? key, this.webViewType = 0}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  String url = "";
  // bool isLoading=true;
  @override
  void initState() {
    if (widget.webViewType == 1) {
      url = ApiUrl.aboutUSPAGE;
    } else if (widget.webViewType == 2) {
      url = ApiUrl.faqPAGE;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppbar(),
      body:
      // Stack(
      //   children: [
          WebView(
            backgroundColor: Colors.white,
            onProgress: (i){

            },
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            // onPageFinished: (finish) {
            //   // setState(() {
            //   //   isLoading = false;
            //   // });
            // 
          ),
          // isLoading?Center(child: CircularProgressIndicator(),):Stack(),
      //   ],
      // ),
    );
  }
}

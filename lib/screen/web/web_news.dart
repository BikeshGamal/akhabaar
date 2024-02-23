import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/constant/const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebNews extends StatefulWidget {
  final String url;
  WebNews({required this.url});

  @override
  State<WebNews> createState() => _WebNewsState();
}

class _WebNewsState extends State<WebNews> {
  double webProgress=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: "AkhA",
            style: GoogleFonts.pacifico(
                color: Const.primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: "BaaR", style: TextStyle(color: Const.secondaryColor))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 5,
              child: LinearProgressIndicator(
                value: webProgress,
                color: Colors.red,
                backgroundColor: Colors.blue,
              ),
            ),
            Container(
              child: Expanded(
                child: WebView(
                  onProgress: (progress) {
                    setState(() {
                      this.webProgress=progress/100;
                    });
                  },
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

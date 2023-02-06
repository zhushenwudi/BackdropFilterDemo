import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:we_slide/we_slide.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const double panelMinSize = 120;
    final double panelMaxSize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: WeSlide(
        panelMinSize: panelMinSize,
        panelMaxSize: panelMaxSize,
        body: body(),
        panel: panel(),
        panelHeader: Container(
          height: panelMinSize,
          color: colorScheme.secondary,
          child: const Center(child: Text("Slide to Up ☝️")),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        Container(
            height: 500,
            color: Colors.red,
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                controller.loadUrl('assets/www/index.html');
              },
              backgroundColor: Colors.greenAccent)
        )
      ],
    );
  }

  Widget panel() {
    const provider = AssetImage("assets/1.png");
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ClipRRect(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: provider, fit: BoxFit.cover)),
            ),
            Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

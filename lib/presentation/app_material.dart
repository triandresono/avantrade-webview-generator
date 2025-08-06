import 'package:avantrade_webview_generator/presentation/webview/controller/webview_binding.dart';
import 'package:avantrade_webview_generator/presentation/webview/view/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Selling Agent",
      navigatorKey: Get.key,
      // initialRoute: RmPath.SPLASH,
      initialBinding: WebviewBinding(),
      home: const WebviewPage(),
    );
  }
}

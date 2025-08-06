import 'package:avantrade_webview_generator/common/case.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_authcode_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b2c_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b_response.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class WebviewModel {
  final b2bCase = Case<WebviewB2bResponse>().obs;
  final b2b2cCase = Case<WebviewB2b2cResponse>().obs;
  final authCodeCase = Case<WebviewAuthcodeResponse>().obs;
  var privateKeySignature = "";
  var secretKeySignature = "";
  var timeStamp = "";

  void showDialog({
    required String value,
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SelectableText(value),
        );
      },
    );
  }
}

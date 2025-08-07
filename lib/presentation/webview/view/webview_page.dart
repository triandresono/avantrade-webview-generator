import 'dart:convert';

import 'package:avantrade_webview_generator/common/case.dart';
import 'package:avantrade_webview_generator/common/util.dart';
import 'package:avantrade_webview_generator/presentation/webview/controller/webview_controller.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_authcode_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b2c_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WebviewPage extends GetView<WebviewController> {
  const WebviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                controller.model.showDialog(
                  context: context,
                  value: Util.privateKeySignature(
                    clientId: controller.constant.clientId,
                    timestamp: controller.model.timeStamp,
                    privateKeyPem: controller.constant.privateKey,
                  ),
                );
              },
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.all(8),
                child: const Text("Private Key Generator"),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              final b2bState = controller.model.b2bCase.value;
              final data = b2bState.data ?? WebviewB2bResponse();
              return InkWell(
                onTap: () {
                  if (b2bState is LoadedCase) {
                    controller.model.showDialog(
                      context: context,
                      value: Util.secretKeySignature(
                        httpMethod: "POST",
                        endpoint: controller.constant.authCodeUri,
                        token: data.accessToken,
                        timestamp: controller.model.timeStamp,
                        // body: json.encode(controller.constant.authCodeBody),
                        body: "",
                        clientSecret: controller.constant.secretKey,
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Error"),
                          content: Text("Need B2B Access Token"),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  color: b2bState is LoadedCase ? Colors.amber : Colors.grey,
                  padding: const EdgeInsets.all(8),
                  child: const Text("Secret Key Generator"),
                ),
              );
            }),
            const SizedBox(height: 30),
            Obx(() {
              final b2bState = controller.model.b2bCase.value;
              final data = b2bState.data ?? WebviewB2bResponse();
              return InkWell(
                onTap: () {
                  if (b2bState is LoadedCase) {
                    controller.model.showDialog(
                      context: context,
                      value: Util.secretKeySignature(
                        httpMethod: "POST",
                        endpoint: controller.constant.localAuthCodeUri,
                        token: data.accessToken,
                        timestamp: controller.model.timeStamp,
                        // body: json.encode(controller.constant.authCodeBody),
                        body: "",
                        clientSecret: controller.constant.secretKey,
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text("Error"),
                          content: Text("Need B2B Access Token"),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  color: b2bState is LoadedCase ? Colors.amber : Colors.grey,
                  padding: const EdgeInsets.all(8),
                  child: const Text("Local Secret Key Generator"),
                ),
              );
            }),
            const SizedBox(height: 30),
            InkWell(
              onTap: () => controller.start(),
              child: Container(
                color: Colors.blueAccent,
                padding: const EdgeInsets.all(8),
                child: const Text("Start"),
              ),
            ),
            Expanded(
              child: Obx(() {
                final b2bState = controller.model.b2bCase.value;
                final authState = controller.model.authCodeCase.value;
                final b2b2cState = controller.model.b2b2cCase.value;
                final b2bData = b2bState.data ?? WebviewB2bResponse();
                final authData = authState.data ?? WebviewAuthcodeResponse();
                final b2b2cData = b2b2cState.data ?? WebviewB2b2cResponse();
                if (b2bState is LoadingCase ||
                    authState is LoadingCase ||
                    b2b2cState is LoadingCase) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      const Divider(),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text("B2B Access Token"),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              if (b2bState is LoadedCase) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("B2B Response"),
                                      content: SelectableText(
                                        json.encode({
                                          "time": controller.model.timeStamp,
                                          ...b2bData.toMap(),
                                        }),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              color: b2bState is LoadedCase
                                  ? Colors.amber
                                  : Colors.grey,
                              padding: const EdgeInsets.all(8),
                              child: const Text("Complete Response"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Colors.grey,
                        child: Builder(builder: (context) {
                          if (b2bState is LoadedCase) {
                            return SelectableText(b2bData.accessToken);
                          } else if (b2bState is ErrorCase) {
                            return Text(b2bState.failure.error);
                          } else {
                            return const Text("No Data");
                          }
                        }),
                      ),
                      const SizedBox(height: 15),
                      const Text("Auth Code"),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Colors.grey,
                        child: Builder(builder: (context) {
                          if (authState is LoadedCase) {
                            return SelectableText(authData.authCode);
                          } else if (authState is ErrorCase) {
                            return Text(authState.failure.error);
                          } else {
                            return const Text("No Data");
                          }
                        }),
                      ),
                      const SizedBox(height: 15),
                      const Text("B2B2C Access Token"),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        color: Colors.grey,
                        child: Builder(builder: (context) {
                          if (b2b2cState is LoadedCase) {
                            return SelectableText(b2b2cData.accessToken);
                          } else if (b2b2cState is ErrorCase) {
                            return Text(b2b2cState.failure.error);
                          } else {
                            return const Text("No Data");
                          }
                        }),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

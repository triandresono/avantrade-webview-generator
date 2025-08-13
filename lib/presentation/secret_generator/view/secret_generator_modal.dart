import 'package:avantrade_webview_generator/common/util.dart';
import 'package:avantrade_webview_generator/presentation/secret_generator/controller/secret_generator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecretGeneratorModal extends GetView<SecretGeneratorController> {
  const SecretGeneratorModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text("TOKEN"),
        const SizedBox(height: 20),
        TextField(
          controller: controller.model.tokenCo,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (controller.model.tokenCo.text.isNotEmpty) {
                  controller.model.value(
                    Util.secretKeySignature(
                      clientSecret: controller.constant.secretKey,
                      timestamp: controller.argument.timeStamp,
                      token: controller.model.value.value,
                      httpMethod: "POST",
                      body: "",
                      endpoint: controller.constant.authCodeGAD.replaceAll(
                        "HTTPS",
                        "HTTP",
                      ),
                    ),
                  );
                }
              },
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.all(8),
                child: const Text("DEPLOYED"),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                if (controller.model.tokenCo.text.isNotEmpty) {
                  controller.model.value(
                    Util.secretKeySignature(
                      clientSecret: controller.constant.secretKey,
                      timestamp: controller.argument.timeStamp,
                      token: controller.model.tokenCo.text,
                      httpMethod: "POST",
                      endpoint: controller.constant.localAuthCodeUri,
                      body: "",
                    ),
                  );
                }
              },
              child: Container(
                color: Colors.amber,
                padding: const EdgeInsets.all(8),
                child: const Text("LOCAL"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Obx(() {
          final value = controller.model.value.value;
          return SelectableText(value);
        }),
      ],
    );
  }
}

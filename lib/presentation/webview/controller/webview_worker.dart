part of 'webview_controller.dart';

mixin _Worker {
  List<Worker> workers(WebviewController controller) {
    return [
      Get.listen(
        listener: controller.model.b2bCase,
        callback: (state) async {
          if (state is LoadedCase) {
            final data = state.data ?? WebviewB2bResponse();
            // TODO : GENERATE SECRET SIGNATURE
            controller.model.secretKeySignature = Util.secretKeySignature(
              endpoint: controller.constant.httpAuthCodeUri,
              clientSecret: controller.constant.secretKey,
              timestamp: controller.model.timeStamp,
              token: data.accessToken,
              httpMethod: "POST",
              body: "",
            );
            //TODO : GENERATE LOCAL SECRET SIGNATURE (ONLY FOR TESTING)
            controller.model.localSecretKeySignature = Util.secretKeySignature(
              endpoint: controller.constant.localAuthCodeUri,
              clientSecret: controller.constant.secretKey,
              timestamp: controller.model.timeStamp,
              token: data.accessToken,
              httpMethod: "POST",
              body: "",
            );
            //TODO : HIT AUTHCODE
            controller.getAuthCode();
          }
        },
      ),
      Get.listen(
        listener: controller.model.authCodeCase,
        callback: (state) async {
          if (state is LoadedCase) {
            //TODO : HIT B2B2C
            controller.getB2b2c();
          }
        },
      ),
      Get.listen(
        listener: controller.model.b2b2cCase,
        callback: (state) async {
          if (state is LoadedCase) {
            //TODO : HIT GENERATE WEBVIEW
            controller.getWebView();
          }
        },
      ),
      Get.listen(
        listener: controller.model.webViewCase,
        callback: (state) {
          if (state is LoadedCase) {
            //TODO : HIT VALIDATE TOKEN
            controller.validateToken();
          }
        },
      ),
      Get.listen(
        listener: controller.model.tokenCase,
        callback: (state) {
          if (state is LoadedCase) {
            //TODO : FINISH
          }
        },
      ),
    ];
  }
}

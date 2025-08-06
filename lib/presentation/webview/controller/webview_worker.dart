part of 'webview_controller.dart';

mixin _Worker {
  List<Worker> workers(WebviewController controller) {
    return [
      Get.listen(
        listener: controller.model.b2bCase,
        callback: (state) {
          if (state is LoadedCase) {
            // HIT AUTHCODE
            controller.getAuthCode();
          } else if (state is ErrorCase) {
            controller.model.authCodeCase(ErrorCase(state.failure));
            controller.model.b2b2cCase(ErrorCase(state.failure));
          }
        },
      ),
      Get.listen(
        listener: controller.model.authCodeCase,
        callback: (state) {
          if (state is LoadedCase) {
            // HIT B2B2C
            controller.getB2b2c();
          } else if (state is ErrorCase) {
            controller.model.b2b2cCase(ErrorCase(state.failure));
          }
        },
      ),
      Get.listen(
        listener: controller.model.b2b2cCase,
        callback: (state) {
          if (state is LoadedCase) {
            // FINISH
          }
        },
      ),
    ];
  }
}

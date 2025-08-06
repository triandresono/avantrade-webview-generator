import 'package:avantrade_webview_generator/presentation/webview/constant/webview_constant.dart';
import 'package:avantrade_webview_generator/presentation/webview/controller/webview_controller.dart';
import 'package:avantrade_webview_generator/presentation/webview/model/webview_model.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/webview_service.dart';
import 'package:avantrade_webview_generator/service/dio/dio_util.dart';
import 'package:get/get.dart';

class WebviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebviewController(
      service: WebViewServiceImpl(DioUtil()),
      constant: WebviewConstant(),
      model: WebviewModel(),
    ));
  }
}

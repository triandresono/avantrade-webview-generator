import 'package:avantrade_webview_generator/common/case.dart';
import 'package:avantrade_webview_generator/common/extension/extension.dart';
import 'package:avantrade_webview_generator/common/util.dart';
import 'package:avantrade_webview_generator/presentation/webview/constant/webview_constant.dart';
import 'package:avantrade_webview_generator/presentation/webview/model/webview_model.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_authcode_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b2c_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_generate_view_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/webview_service.dart';
import 'package:avantrade_webview_generator/shared/getx_state.dart';
import 'package:get/get.dart';
part 'webview_worker.dart';

class WebviewController extends GetxState with _Worker {
  final WebviewService service;
  final WebviewConstant constant;
  final WebviewModel model;

  WebviewController({
    required this.service,
    required this.constant,
    required this.model,
  });

  @override
  void onInit() {
    (this).disposables.addAll(workers(this));
    // model.timeStamp = DateFormat(constant.dateFormat).format(DateTime.now());
    model.timeStamp = Util.formatWithOffset(DateTime.now());
    model.privateKeySignature = Util.privateKeySignature(
      clientId: constant.clientId,
      timestamp: model.timeStamp,
      privateKeyPem: constant.privateKey,
    );
    super.onInit();
  }

  void getB2b() async {
    model.b2bCase(LoadingCase());
    final response = await service.getb2b(
      privateKeysignature: model.privateKeySignature,
      clientId: constant.clientId,
      timeStamp: model.timeStamp,
      body: {"grantType": "client_credentials"},
    );
    response.fold(
      (failure) => model.b2bCase(ErrorCase(failure)),
      (result) => model.b2bCase(LoadedCase(result)),
    );
  }

  void getAuthCode() async {
    model.authCodeCase(LoadingCase());
    final data = model.b2bCase.value.data ?? WebviewB2bResponse();
    final response = await service.getAuthCode(
      secretKeySignature: model.secretKeySignature,
      b2bToken: data.accessToken,
      clientId: constant.clientId,
      sessionId: data.sessionId,
      branchId: constant.clientId,
      timeStamp: model.timeStamp,
      body: {
        "paramType": "CIF_BANK",
        "paramValue": "CIF2511063896",
        "partnerChannel": "CH_BPI"
      },
    );
    response.fold(
      (failure) => model.authCodeCase(ErrorCase(failure)),
      (result) => model.authCodeCase(LoadedCase(result)),
    );
  }

  void getB2b2c() async {
    model.b2b2cCase(LoadingCase());
    final authData = model.authCodeCase.value.data ?? WebviewAuthcodeResponse();
    final b2bData = model.b2bCase.value.data ?? WebviewB2bResponse();
    final response = await service.getb2b2c(
      privateKeySignature: model.privateKeySignature,
      b2bToken: b2bData.accessToken,
      clientId: constant.clientId,
      branchId: constant.clientId,
      timeStamp: model.timeStamp,
      body: {
        "grantType": "AUTHORIZATION_CODE",
        "authCode": authData.authCode,
        "refreshToken": ""
      },
    );
    response.fold(
      (failure) => model.b2b2cCase(ErrorCase(failure)),
      (result) => model.b2b2cCase(LoadedCase(result)),
    );
  }

  void getWebView() async {
    model.webViewCase(LoadingCase());
    final b2b2cData = model.b2b2cCase.value.data ?? WebviewB2b2cResponse();
    final response = await service.getWebview(
      b2b2cToken: b2b2cData.accessToken,
    );
    response.fold(
      (failure) => model.webViewCase(ErrorCase(failure)),
      (result) => model.webViewCase(LoadedCase(result)),
    );
  }

  void validateToken() async {
    model.tokenCase(LoadingCase());
    final data = model.webViewCase.value.data ?? WebviewGenerateViewResponse();
    final response = await service.validateToken(
      webViewToken: data.authCode,
    );
    response.fold(
      (failure) => model.tokenCase(ErrorCase(failure)),
      (result) => model.tokenCase(LoadedCase(result)),
    );
  }
}

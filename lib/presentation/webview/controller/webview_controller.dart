import 'dart:convert';

import 'package:avantrade_webview_generator/common/case.dart';
import 'package:avantrade_webview_generator/common/extension/extension.dart';
import 'package:avantrade_webview_generator/common/util.dart';
import 'package:avantrade_webview_generator/presentation/webview/constant/webview_constant.dart';
import 'package:avantrade_webview_generator/presentation/webview/model/webview_model.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_authcode_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b_response.dart';
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
    super.onInit();
  }

  void start() async {
    model.b2bCase(LoadingCase());
    model.authCodeCase(LoadingCase());
    model.b2b2cCase(LoadingCase());
    getB2b();
  }

  void getB2b() async {
    final response = await service.getb2b(
      clientId: constant.clientId,
      timeStamp: model.timeStamp,
      body: {"grantType": "client_credentials"},
      privateKeysignature: Util.privateKeySignature(
        clientId: constant.clientId,
        timestamp: model.timeStamp,
        privateKeyPem: constant.privateKey,
      ),
    );
    response.fold(
      (failure) => model.b2bCase(ErrorCase(failure)),
      (result) => model.b2bCase(LoadedCase(result)),
    );
  }

  void getAuthCode() async {
    final data = model.b2bCase.value.data ?? WebviewB2bResponse();
    final response = await service.getAuthCode(
      b2bToken: data.accessToken,
      clientId: constant.clientId,
      sessionId: data.sessionId,
      branchId: constant.branchId,
      timeStamp: model.timeStamp,
      body: {
        "paramType": "CIF_BANK",
        "paramValue": "CIF2511063896",
        "partnerChannel": "CH_BPI"
      },
      secretKeySignature: Util.secretKeySignature(
        httpMethod: "POST",
        endpoint: constant.authCodeUri,
        token: data.accessToken,
        timestamp: model.timeStamp,
        // body: json.encode(constant.authCodeBody),
        clientSecret: constant.secretKey,
        body: "",
      ),
    );
    response.fold(
      (failure) => model.authCodeCase(ErrorCase(failure)),
      (result) => model.authCodeCase(LoadedCase(result)),
    );
  }

  void getB2b2c() async {
    final authData = model.authCodeCase.value.data ?? WebviewAuthcodeResponse();
    final b2bData = model.b2bCase.value.data ?? WebviewB2bResponse();
    final response = await service.getb2b2c(
      b2bToken: b2bData.accessToken,
      clientId: constant.clientId,
      branchId: constant.branchId,
      timeStamp: model.timeStamp,
      privateKeySignature: Util.privateKeySignature(
        clientId: constant.clientId,
        timestamp: model.timeStamp,
        privateKeyPem: constant.privateKey,
      ),
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
}

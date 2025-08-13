import 'dart:convert';

import 'package:avantrade_webview_generator/common/either.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_authcode_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b2c_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_b2b_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_generate_view_response.dart';
import 'package:avantrade_webview_generator/presentation/webview/service/response/webview_validate_token_response.dart';
import 'package:avantrade_webview_generator/service/dio/dio_util.dart';
import 'package:avantrade_webview_generator/service/response/base_response.dart';
import 'package:basic_utils/basic_utils.dart';

abstract class WebviewService {
  Future<Either<BaseResponse, WebviewB2bResponse>> getb2b({
    required String privateKeysignature,
    required String clientId,
    required String timeStamp,
    required Map<String, dynamic> body,
  });

  Future<Either<BaseResponse, WebviewAuthcodeResponse>> getAuthCode({
    required String secretKeySignature,
    required String b2bToken,
    required String clientId,
    required String sessionId,
    required String branchId,
    required String timeStamp,
    required Map<String, dynamic> body,
  });

  Future<Either<BaseResponse, WebviewB2b2cResponse>> getb2b2c({
    required String privateKeySignature,
    required String b2bToken,
    required String clientId,
    required String branchId,
    required String timeStamp,
    required Map<String, dynamic> body,
  });

  Future<Either<BaseResponse, WebviewGenerateViewResponse>> getWebview({
    required String b2b2cToken,
  });

  Future<Either<BaseResponse, WebviewValidateTokenResponse>> validateToken({
    required String webViewToken,
  });
}

class WebViewServiceImpl implements WebviewService {
  final DioUtil dio;
  WebViewServiceImpl(this.dio);

  @override
  Future<Either<BaseResponse, WebviewAuthcodeResponse>> getAuthCode({
    required String secretKeySignature,
    required String b2bToken,
    required String clientId,
    required String sessionId,
    required String branchId,
    required String timeStamp,
    required Map<String, dynamic> body,
  }) async {
    try {
      final map = await dio.post(
        uri: "auth-service/authentication/v1/generate-auth-code/b2b2c",
        authorization: b2bToken,
        body: body,
        headers: {
          "X-BRANCH-ID": branchId,
          "X-TIMESTAMP": timeStamp,
          "X-PARTNER-ID": clientId,
          "X-SESSION-ID": sessionId,
          "X-SIGNATURE": secretKeySignature,
        },
      );
      return Right(WebviewAuthcodeResponse.fromMap(map));
    } catch (e) {
      return Left(BaseResponse.exception(e));
    }
  }

  @override
  Future<Either<BaseResponse, WebviewB2bResponse>> getb2b({
    required String privateKeysignature,
    required String clientId,
    required String timeStamp,
    required Map<String, dynamic> body,
  }) async {
    try {
      final map = await dio.post(
        uri: "auth-service/authentication/v1/access-token/b2b",
        body: body,
        headers: {
          "X-CLIENT-KEY": clientId,
          "X-TIMESTAMP": timeStamp,
          "X-SIGNATURE": privateKeysignature,
        },
      );
      return Right(WebviewB2bResponse.fromMap(map));
    } catch (e) {
      return Left(BaseResponse.exception(e));
    }
  }

  @override
  Future<Either<BaseResponse, WebviewB2b2cResponse>> getb2b2c({
    required String privateKeySignature,
    required String b2bToken,
    required String clientId,
    required String branchId,
    required String timeStamp,
    required Map<String, dynamic> body,
  }) async {
    try {
      final map = await dio.post(
        uri: "auth-service/authentication/v1/access-token/b2b2c",
        body: body,
        headers: {
          "AUTHORIZATION-CUSTOMER": b2bToken,
          "X-BRANCH-ID": branchId,
          "X-TIMESTAMP": timeStamp,
          "X-PARTNER-ID": clientId,
          "X-CLIENT-KEY": clientId,
          "X-SIGNATURE": privateKeySignature,
        },
      );
      return Right(WebviewB2b2cResponse.fromMap(map));
    } catch (e) {
      return Left(BaseResponse.exception(e));
    }
  }

  @override
  Future<Either<BaseResponse, WebviewGenerateViewResponse>> getWebview({
    required String b2b2cToken,
  }) async {
    try {
      final map = await dio.post(
        uri: "auth-service/authentication/token/by-b2bc-token",
        authorization: b2b2cToken,
        headers: {
          "authorization-customer": b2b2cToken,
        },
      );
      return Right(WebviewGenerateViewResponse.fromMap(map));
    } catch (e) {
      return Left(BaseResponse.exception(e));
    }
  }

  @override
  Future<Either<BaseResponse, WebviewValidateTokenResponse>> validateToken({
    required String webViewToken,
  }) async {
    try {
      final map = await dio.post(
        uri: "auth-service/auth/validate-token/b2b2c",
        authorization: webViewToken,
      );
      return Right(WebviewValidateTokenResponse.fromMap(map));
    } catch (e) {
      return Left(BaseResponse.exception(e));
    }
  }
}

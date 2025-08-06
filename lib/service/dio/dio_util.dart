import 'dart:async';
import 'dart:io';

import 'package:avantrade_webview_generator/service/exception.dart';
import 'package:avantrade_webview_generator/service/response/base_response.dart';
import 'package:dio/dio.dart';

part 'dio_extension.dart';

class DioUtil {
  final _dio = Dio();
  factory DioUtil() => _instance;
  static final DioUtil _instance = DioUtil._internal();
  final baseUri = "https://dev-ava-be.devops.indivaragroup.com/";
  // final baseUri = "http://localhost:8080/";
  DioUtil._internal() {
    _dio.options.connectTimeout = const Duration(milliseconds: 90000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
    };
  }

  Future<Map<String, dynamic>> post({
    required String uri,
    String? authorization,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    if (authorization != null) _dio.addToken(authorization);
    if (headers != null) _dio.addHeader(headers);
    try {
      var res = await _dio.post(
        baseUri + uri,
        data: body,
        queryParameters: param,
      );
      // return _handleResponse(res);
      return res.data;
    } on DioException catch (error) {
      return _handleError(error);
    } on Exception {
      rethrow;
    }
  }

  Future<dynamic> postDownload({
    required String uri,
    String? authorization,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    if (authorization != null) _dio.addToken(authorization);
    if (headers != null) _dio.addHeader(headers);
    try {
      var res = await _dio.post(
        baseUri + uri,
        data: body,
        queryParameters: param,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      return res.data;
    } on DioException catch (error) {
      return _handleError(error);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get({
    required String uri,
    String? authorization,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    if (authorization != null) _dio.addToken(authorization);
    if (headers != null) _dio.addHeader(headers);
    try {
      var res = await _dio.get(
        baseUri + uri,
        queryParameters: param,
      );
      return _handleResponse(res);
    } on DioException catch (error) {
      return _handleError(error);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> delete({
    required String uri,
    String? authorization,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    if (authorization != null) _dio.addToken(authorization);
    if (headers != null) _dio.addHeader(headers);
    try {
      var res = await _dio.delete(
        baseUri + uri,
        queryParameters: param,
      );
      return _handleResponse(res);
    } on DioException catch (error) {
      return _handleError(error);
    } on Exception {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> put({
    required String uri,
    String? authorization,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    if (authorization != null) _dio.addToken(authorization);
    if (headers != null) _dio.addHeader(headers);
    try {
      var res = await _dio.put(
        baseUri + uri,
        data: body,
        queryParameters: param,
      );
      return res.data;
    } on DioException catch (error) {
      return _handleError(error);
    } on Exception {
      rethrow;
    }
  }

  /////////////////////////HANDLE RESPONSE////////////////////////////////////
  dynamic _handleResponse(Response res) {
    if (res.data['success'] != null && res.data['success'] == true) {
      return res.data;
    } else if (res.statusCode! != 200) {
      throw ErrorResponse.mapErrorResponse(
        statusCode: res.statusCode,
        message: res.data["errors"] ?? "Internal server error",
        errorCode: res.data['errorCodes'],
        errors: res.data['errors'],
      );
    } else if (res.data['success'] == false && res.statusCode == 200) {
      var base = BaseResponse.fromMap(res.data ?? {});
      return ErrorResponse.mapErrorResponse(
        statusCode: res.statusCode,
        message: base.error,
        errorCode: base.status.toString(),
        errors: base.error,
      );
    } else if (res.data['success'] != null && res.data['success'] == false) {
      //return res.data;
      var base = BaseResponse.fromMap(res.data);
      throw ErrorResponse.customError(
        statusCode: res.statusCode,
        message: base.error,
        errorCode: base.status.toString(),
        errors: base.error,
      );
    }
  }

  dynamic _handleError(DioException res) {
    if (res.error is SocketException) {
      throw FetchDataException(
        message: res.message ?? '-',
        statusCode: 600,
      );
    } else if (res.error is TimeoutException) {
      throw FetchDataException(
        message: res.message ?? '-',
        statusCode: 408,
      );
    } else if (res.response?.statusCode == 403) {
      return ErrorResponse.mapErrorResponse(
        statusCode: 403,
        message: "Access Forbiden",
        errorCode: "403",
        errors: "Access Forbiden",
      );
    } else {
      var base = BaseResponse.fromMap(res.response?.data ?? {});
      return ErrorResponse.mapErrorResponse(
        statusCode: res.response?.statusCode,
        message: res.message ?? base.error,
        errorCode: base.status.toString(),
        errors: res.message ?? base.error,
      );
    }
  }

  Future<Map<String, dynamic>> postList({
    required String uri,
    String? authorization,
    List<Map<String, dynamic>>? body,
    Map<String, String>? headers,
    Map<String, String>? param,
    encoding,
  }) async {
    if (authorization != null) _dio.addToken(authorization);
    if (headers != null) _dio.addHeader(headers);
    try {
      var res = await _dio.post(uri, data: body, queryParameters: param);
      return _handleResponse(res);
    } on DioException catch (error) {
      return _handleError(error);
    } on Exception {
      rethrow;
    }
  }
}

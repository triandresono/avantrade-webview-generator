import 'package:avantrade_webview_generator/service/exception.dart';

class BaseResponse {
  final String timeStamp;
  final String path;
  final String error;
  final String requestId;
  final num status;
  final dynamic data;

  BaseResponse({
    this.timeStamp = "",
    this.path = "",
    this.error = "",
    this.requestId = "",
    this.status = 0,
    this.data,
  });

  factory BaseResponse.exception(Object e) {
    if (e is FetchDataException) {
      return BaseResponse(error: e.message);
    } else {
      return BaseResponse(error: e.toString());
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeStamp': timeStamp,
      'path': path,
      'error': error,
      'requestId': requestId,
      'status': status,
      'data': data,
    };
  }

  factory BaseResponse.fromMap(Map<String, dynamic> map) {
    return BaseResponse(
      timeStamp: map['timeStamp'] ?? '',
      path: map['path'] ?? '',
      error: map['error'] ?? '',
      requestId: map['requestId'] ?? '',
      status: map['status'] ?? 0,
      data: map['data'],
    );
  }
}

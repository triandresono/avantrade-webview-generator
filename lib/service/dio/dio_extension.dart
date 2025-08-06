part of 'dio_util.dart';

extension DioEx on Dio {
  void addHeader(Map<String, dynamic> header) {
    (this).options.headers.addAll(header);
  }

  void addToken(String token) {
    (this).options.headers.addAll({'Authorization': 'Bearer $token'});
  }
}

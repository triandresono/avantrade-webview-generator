import 'package:avantrade_webview_generator/service/response/base_response.dart';

class Case<T> {
  final T? data;
  final Map<String, dynamic> payload;
  final BaseResponse failure;

  Case({
    this.data,
    this.payload = const {},
    BaseResponse? failure,
  }) : failure = failure ?? BaseResponse();
}

class InitialCase<T> extends Case<T> {}

class InitLoadingCase<T> extends Case<T> {}

class LoadingCase<T> extends Case<T> {}

class CancelCase<T> extends Case<T> {}

class ExceptionCase<T> extends Case<T> {
  ExceptionCase(Exception e) : super(failure: BaseResponse.exception(e));
}

class ErrorCase<T> extends Case<T> {
  ErrorCase(BaseResponse failure) : super(failure: failure);
}

class LoadedCase<T> extends Case<T> {
  LoadedCase(T result) : super(data: result);
}

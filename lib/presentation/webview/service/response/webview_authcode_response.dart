class WebviewAuthcodeResponse {
  final String authCode;

  WebviewAuthcodeResponse({this.authCode = ""});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authCode': authCode,
    };
  }

  factory WebviewAuthcodeResponse.fromMap(Map<String, dynamic> map) {
    return WebviewAuthcodeResponse(
      authCode: map['authCode'] ?? "",
    );
  }
}

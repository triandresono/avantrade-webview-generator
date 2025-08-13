class WebviewGenerateViewResponse {
  final String successCode;
  final String successMessage;
  final String authCode;
  final String id;
  final String branchId;
  final String webviewUrl;

  WebviewGenerateViewResponse({
    this.successCode = "",
    this.successMessage = "",
    this.authCode = "",
    this.id = "",
    this.branchId = "",
    this.webviewUrl = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'successCode': successCode,
      'successMessage': successMessage,
      'authCode': authCode,
      'id': id,
      'branchId': branchId,
      'webviewUrl': webviewUrl,
    };
  }

  factory WebviewGenerateViewResponse.fromMap(Map<String, dynamic> map) {
    return WebviewGenerateViewResponse(
      successCode: map['successCode'] ?? '',
      successMessage: map['successMessage'] ?? '',
      authCode: map['authCode'] ?? '',
      id: map['id'] ?? '',
      branchId: map['branchId'] ?? '',
      webviewUrl: map['webviewUrl'] ?? '',
    );
  }
}

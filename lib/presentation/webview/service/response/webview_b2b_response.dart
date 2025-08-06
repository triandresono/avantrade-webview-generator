class WebviewB2bResponse {
  final String accessToken;
  final String tokenType;
  final String expiresIn;
  final String sessionId;

  WebviewB2bResponse({
    this.accessToken = "",
    this.tokenType = "",
    this.expiresIn = "",
    this.sessionId = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'sessionId': sessionId,
    };
  }

  factory WebviewB2bResponse.fromMap(Map<String, dynamic> map) {
    return WebviewB2bResponse(
      accessToken: map['accessToken'] ?? "",
      tokenType: map['tokenType'] ?? "",
      expiresIn: map['expiresIn'] ?? "",
      sessionId: map['sessionId'] ?? "",
    );
  }
}

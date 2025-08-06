class WebviewB2b2cResponse {
  final String accessToken;
  final String tokenType;
  final String accessTokenExpiryTime;
  final String refreshToken;
  final String refreshTokenExpiryTime;

  WebviewB2b2cResponse({
    this.accessToken = "",
    this.tokenType = "",
    this.accessTokenExpiryTime = "",
    this.refreshToken = "",
    this.refreshTokenExpiryTime = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'tokenType': tokenType,
      'accessTokenExpiryTime': accessTokenExpiryTime,
      'refreshToken': refreshToken,
      'refreshTokenExpiryTime': refreshTokenExpiryTime,
    };
  }

  factory WebviewB2b2cResponse.fromMap(Map<String, dynamic> map) {
    return WebviewB2b2cResponse(
      accessToken: map['accessToken'] ?? '',
      tokenType: map['tokenType'] ?? '',
      accessTokenExpiryTime: map['accessTokenExpiryTime'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      refreshTokenExpiryTime: map['refreshTokenExpiryTime'] ?? '',
    );
  }
}

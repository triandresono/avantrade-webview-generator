class WebviewValidateTokenResponse {
  final WebviewValidateTokenDataResponse data;

  WebviewValidateTokenResponse({WebviewValidateTokenDataResponse? data})
      : data = data ?? WebviewValidateTokenDataResponse();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
    };
  }

  factory WebviewValidateTokenResponse.fromMap(Map<String, dynamic> map) {
    return WebviewValidateTokenResponse(
      data: map['data'] != null
          ? WebviewValidateTokenDataResponse.fromMap(map['data'])
          : WebviewValidateTokenDataResponse(),
    );
  }
}

class WebviewValidateTokenDataResponse {
  final String token;
  final String sessionId;
  final String email;
  final String loginId;
  final String userId;
  final String accountId;
  final String branchId;
  final String channel;
  final String channelId;

  WebviewValidateTokenDataResponse({
    this.token = "",
    this.sessionId = "",
    this.email = "",
    this.loginId = "",
    this.userId = "",
    this.accountId = "",
    this.branchId = "",
    this.channel = "",
    this.channelId = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'sessionId': sessionId,
      'email': email,
      'loginId': loginId,
      'userId': userId,
      'accountId': accountId,
      'branchId': branchId,
      'channel': channel,
      'channelId': channelId,
    };
  }

  factory WebviewValidateTokenDataResponse.fromMap(Map<String, dynamic> map) {
    return WebviewValidateTokenDataResponse(
      token: map['token'] ?? '',
      sessionId: map['sessionId'] ?? '',
      email: map['email'] ?? '',
      loginId: map['loginId'] ?? '',
      userId: map['userId'] ?? '',
      accountId: map['accountId'] ?? '',
      branchId: map['branchId'] ?? '',
      channel: map['channel'] ?? '',
      channelId: map['channelId'] ?? '',
    );
  }
}

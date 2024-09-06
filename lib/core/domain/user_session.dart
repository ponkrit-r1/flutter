import 'dart:convert';

class UserSession {
  final String accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? refreshToken;
  final DateTime? createdAt;

  // bool get isExpired {
  //   final expiredAt = createdAt.add(Duration(seconds: expiresIn));
  //   return DateTime.now().isAfter(expiredAt);
  // }

  UserSession({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory UserSession.fromMap(Map<String, dynamic> map) {
    return UserSession(
      accessToken: map['key'] ?? '',
      tokenType: map['token_type'] ?? '',
      expiresIn: map['expires_in']?.toInt() ?? 0,
      refreshToken: map['refresh_token'] ?? '',
      createdAt: null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory UserSession.fromJson(Map<String, dynamic> source) =>
      UserSession.fromMap(source);

  static String serialize(UserSession model) => json.encode(model.toMap());
  static UserSession deserialize(String source) =>
      UserSession.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserSession(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, refreshToken: $refreshToken, createdAt: $createdAt)';
  }
}

import 'dart:convert';

class UserSession {
  final String accessToken;
  final DateTime? expiresAt;
  final String? refreshToken;
  final String? lifeTime;

  UserSession({
    required this.accessToken,
    this.expiresAt,
    required this.refreshToken,
    this.lifeTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'access': accessToken,
      'access_token_expiry': expiresAt?.toIso8601String(),
      'refresh': refreshToken,
      'access_token_lifetime': lifeTime,
    };
  }

  factory UserSession.fromMap(Map<String, dynamic> map) {
    return UserSession(
      accessToken: map['access'] ?? '',
      expiresAt: map['access_token_expiry'] != null
          ? DateTime.parse(map['access_token_expiry'])
          : null,
      refreshToken: map['refresh'] ?? '',
      lifeTime: map['access_token_lifetime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory UserSession.fromJson(Map<String, dynamic> source) =>
      UserSession.fromMap(source);

  String get serialize => json.encode(toMap());

  static UserSession deserialize(String source) =>
      UserSession.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserSession(accessToken: $accessToken, expiresAt: $expiresAt, refreshToken: $refreshToken, lifetime: $lifeTime)';
  }
}

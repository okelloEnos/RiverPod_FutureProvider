// To parse this JSON data, do
//
//     final tokenResponse = tokenResponseFromJson(jsonString);

import 'dart:convert';

TokenResponse tokenResponseFromJson(String str) => TokenResponse.fromJson(json.decode(str));

String tokenResponseToJson(TokenResponse data) => json.encode(data.toJson());

class TokenResponse {
  TokenResponse({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
  });

  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    accessToken: json["access_token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "expires_in": expiresIn,
    "access_token": accessToken,
    "refresh_token": refreshToken,
  };
}

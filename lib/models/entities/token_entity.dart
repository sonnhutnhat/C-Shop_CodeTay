import 'package:equatable/equatable.dart';

class TokenEntity extends Equatable {
  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenEntity.fromJson(Map<String, dynamic> json) {
    return TokenEntity(
      accessToken: json['access_token'] as String? ?? '',
      refreshToken: json['refresh_token'] as String? ?? '',
    );
  }

  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };

  @override
  List<Object?> get props => <Object?>[accessToken, refreshToken];
}

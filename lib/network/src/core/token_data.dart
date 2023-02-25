import 'package:equatable/equatable.dart';

class TokenData extends Equatable {
  final String accessToken;
  final String refreshToken;

  const TokenData({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  @override
  String toString() => 'TokenData{accessToken: $accessToken}';
}

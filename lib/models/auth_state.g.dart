// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return AuthState(
    loginRequest: json['loginRequest'] as bool,
    loginSuccess: json['loginSuccess'] as bool,
    loginFail: json['loginFail'] as bool,
    logout: json['logout'] as bool,
  );
}

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'loginRequest': instance.loginRequest,
      'loginSuccess': instance.loginSuccess,
      'loginFail': instance.loginFail,
      'logout': instance.logout,
    };

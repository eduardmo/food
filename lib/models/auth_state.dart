import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'auth_state.g.dart';

@JsonSerializable(nullable: true)
@immutable
class AuthState {
  final bool loginRequest;
  final bool loginSuccess;
  final bool loginFail;
  final bool logout;

  AuthState(
      {this.loginRequest = false,
      this.loginSuccess = false,
      this.loginFail = false,
      this.logout = false,
     });

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  AuthState copyWith({
    final bool loginRequest,
    final bool loginSuccess,
    final bool loginFail,
    final bool logout,
    final bool logoutRequest,
  }) {
    return new AuthState(
      loginRequest: loginRequest ?? this.loginRequest,
      loginSuccess: loginSuccess ?? this.loginSuccess,
      loginFail: loginFail ?? this.loginFail,
      logout: logout ?? this.logout,
    );
  }

  @override
  String toString() {
    return '''{
                loginRequest: $loginRequest,
                loginSuccess: $loginSuccess,
                loginFail: $loginFail,
                logout: $logout,
            }''';
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/models/user.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_state.g.dart';

@JsonSerializable()
@immutable
class AuthState {
  final bool loginRequest;
  final bool loginSuccess;
  final bool loginFail;
  final bool logout;
  final User currentUser;

  AuthState(
      {this.loginRequest = false,
      this.loginSuccess = false,
      this.loginFail = false,
      this.logout = false,
      this.currentUser,
     });

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);

  AuthState copyWith({
    final User currentUser,
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
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  String toString() {
    return '''{
                loginRequest: $loginRequest,
                loginSuccess: $loginSuccess,
                loginFail: $loginFail,
                logout: $logout,
                currentuser: $currentUser,
            }''';
  }
}

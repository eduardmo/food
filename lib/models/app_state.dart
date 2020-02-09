import 'package:meta/meta.dart';
import 'auth_state.dart';

@immutable
class AppState {
  final AuthState auth;

  AppState({
    AuthState auth,
  }) : auth = auth ?? new AuthState();

  factory AppState.fromJson(Map<String, dynamic> json) => AppState(
    auth: json['auth'] == null ? null : AuthState.fromJson(json['auth'] as Map<String, dynamic>),
  );

  static AppState rehydrationJSON(dynamic json) {
    if(json == null) return null;
    return new AppState(
          auth: json['auth'] == null ? null : new AuthState.fromJson(json['auth'] ),
          );
  }

  Map<String, dynamic> toJson() => {
      'auth': auth.toJson(),
    };

  AppState copyWith({
    AuthState auth,
  }) {
    return new AppState(
      auth: auth ?? this.auth,

    );
  }

  @override
  String toString() {
    return '''AppState{
      auth: $auth,
    }''';
  }
}

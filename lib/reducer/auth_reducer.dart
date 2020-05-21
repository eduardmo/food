import 'package:food/actions/auth_action.dart';
import 'package:food/models/auth_state.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authReducer = combineReducers([
    new TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
    new TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
    new TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
    new TypedReducer<AuthState, UserLogout>(userLogoutReducer),
]);

AuthState userLoginRequestReducer(AuthState auth, UserLoginRequest action) {
    return auth.copyWith(
        loginRequest: true,
        loginSuccess: false,
        loginFail: false,
        logout: false,
        logoutRequest: false
    );
}

AuthState userLoginSuccessReducer(AuthState auth, UserLoginSuccess action) {
    return auth.copyWith(
       loginSuccess: true,
       loginRequest: false,
       loginFail: false,
       logout: false,
       logoutRequest: false,
    );
}

AuthState userLoginFailureReducer(AuthState auth, UserLoginFailure action) {
    return auth.copyWith(
      loginFail: true,
      loginRequest: false,
      loginSuccess: false,
      logout: true,
      logoutRequest: false
    );
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
 return new AuthState();
}



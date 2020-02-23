import 'package:food/models/user_state.dart';

class SetUserState {
  final UserState userState;

  SetUserState(this.userState);

  @override
  String toString() {
    return 'SetUserState {User: $userState}';
  }
}

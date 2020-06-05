import 'package:json_annotation/json_annotation.dart';
part 'user_state.g.dart';

@JsonSerializable(nullable: false)
class UserState {
  final String name;
  final String email;
  final String uid;
  final double balance;
  final bool isAdmin;

  UserState({this.name, this.email, this.balance,this.uid, this.isAdmin});

  Map<String, dynamic> toJson() => _$UserStateToJson(this);

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  UserState copyWith(
      {final String name,
      final String email,
      final String uid,
      final double balance,
      final bool isAdmin,
     }) {
    return new UserState(
        name: name ?? this.name,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        balance:balance?? this.balance,
        isAdmin: isAdmin ?? this.isAdmin
       );
  }

  @override
  String toString() {
    return "{name: $name, email: $email, uid: $uid,isAdmin:$isAdmin}";
  }
}

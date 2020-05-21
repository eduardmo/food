import 'package:food/models/cart_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_state.g.dart';

@JsonSerializable(nullable: false)
class UserState {
  final String name;
  final String email;
  final String uid;
  final bool isAdmin;
  @JsonKey(nullable: true)
  final List<MenuState> adminMenus;

  UserState({this.name, this.email, this.uid, this.isAdmin, this.adminMenus});

  Map<String, dynamic> toJson() => _$UserStateToJson(this);

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  UserState copyWith(
      {final String name,
      final String email,
      final String uid,
      final bool isAdmin,
      final List<MenuState> adminMenus,
     }) {
    return new UserState(
        name: name ?? this.name,
        email: email ?? this.email,
        uid: uid ?? this.uid,
        isAdmin: isAdmin ?? this.isAdmin,
        adminMenus: adminMenus ?? this.adminMenus,
       );
  }

  @override
  String toString() {
    return "{name: $name, email: $email, uid: $uid,isAdmin:$isAdmin,adminMenus:$adminMenus}";
  }
}

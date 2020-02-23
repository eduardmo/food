import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  final String name;
  final String email;
  final String uid;
  final bool isAdmin;

  User(this.name, this.email, this.uid, this.isAdmin);

  @override
  String toString() {
    return "{name: $name, email: $email, uid: $uid,isAdmin:$isAdmin}";
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

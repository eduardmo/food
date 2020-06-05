import 'package:food/models/master_order_state.dart';
import 'package:food/models/menu_state.dart';
import 'package:food/models/topup_request_state.dart';
import 'package:food/models/user_state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'admin_state.g.dart';

@JsonSerializable()
class AdminState {
  @JsonKey(nullable: true)
  final List<UserState> users;
  @JsonKey(nullable: true)
  final List<MenuState> menus;
  @JsonKey(nullable: true)
  final List<TopUpRequestState> topUpRequestStates;
  @JsonKey(nullable: true)
  final List<MasterOrderState> masterOrderStates;


  AdminState({this.users, this.menus, this.topUpRequestStates,this.masterOrderStates});

  Map<String, dynamic> toJson() => _$AdminStateToJson(this);

  factory AdminState.fromJson(Map<String, dynamic> json) =>
      _$AdminStateFromJson(json);

  AdminState copyWith(
      {final List<UserState> users,
      final List<MenuState> menus,
      final List<TopUpRequestState> topUpRequestStates,
      final List<MasterOrderState> masterOrderStates}) {
    return new AdminState(
        users: users ?? this.users,
        menus: menus ?? this.menus,
        masterOrderStates: masterOrderStates ?? this.masterOrderStates,
        topUpRequestStates: topUpRequestStates ?? this.topUpRequestStates);
  }

  @override
  String toString() {
    return "{users: $users,menus: $menus}";
  }
}

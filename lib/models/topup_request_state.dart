import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topup_request_state.g.dart';

@JsonSerializable()
@immutable
class TopUpRequestState {
  final String id;
  final double balance;
  final String image;
  final bool approved;
  final bool completed;
  final String userid;
  final DateTime dateTime;

  TopUpRequestState({this.id, this.balance, this.image,this.approved,this.completed,this.userid,this.dateTime});

  Map<String, dynamic> toJson() => _$TopUpRequestStateToJson(this);

  factory TopUpRequestState.fromJson(Map<String, dynamic> json) =>
      _$TopUpRequestStateFromJson(json);

  TopUpRequestState copyWith(
      {
      final String id,
      final double balance,
      final String image,
      final bool approved,
      final bool completed,
      final String userid,
      final DateTime dateTime
      }) {
    return new TopUpRequestState(
        id: id ?? this.id,
        balance: balance ?? this.balance,
        image: image ?? this.image,
        approved: approved?? this.approved,
        completed: completed?? this.completed,
        userid: userid?? this.userid,
        dateTime: dateTime?? this.dateTime);
  }

  @override
  String toString() {
    return "{id: $id,balance:$balance,image:$image,approved:$approved,completed:$completed,userid:$userid,dateTime:$dateTime}";
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Room extends Equatable {
  Room({
    this.id,
    @required this.name,
    @required this.hostUsername,
    this.startTime,
    this.endTime,
    // this.userUsages,
  });

  final String id;
  final String name;
  final String hostUsername;
  final DateTime startTime;
  final DateTime endTime;
  // Map<String, int> userUsages = {};

  @override
  List<Object> get props => [id, name, hostUsername];

  bool get hasEnded => endTime.millisecondsSinceEpoch != -62135596800000;

  factory Room.fromJson(Map<String, dynamic> json) {
    print(json);
    return Room(
      id: json['id'],
      name: json['name'],
      hostUsername: json['hostUsername'],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
      // userUsages: Map<String, int>.fromIterables(
      //   (json['userUsages'] as Map<String, dynamic>).keys,
      //   (json['userUsages'] as Map<String, dynamic>)
      //       .values
      //       .map((it) => it as int),
      // ),
    );
  }

  @override
  String toString() =>
      'Room { id: $id, name: $name, hostUsername: $hostUsername }';
}

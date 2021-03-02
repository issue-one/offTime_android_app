import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

@immutable
class Room extends Equatable {
  Room({
    this.id,
    @required this.name,
    @required this.hostUsername,
    this.startTime,
    this.endTime,
    this.userUsages,
  });

  final String id;
  final String name;
  final String hostUsername;
  final DateTime startTime;
  final DateTime endTime;
  Map<String, int> userUsages = {};

  @override
  List<Object> get props => [id, name, hostUsername];

  bool get hasEnded => endTime.millisecondsSinceEpoch != -62135596800000;

  factory Room.fromJson(Map<String, dynamic> json) {
    final room = Room(
      id: json['id'],
      name: json['name'],
      hostUsername: json['hostUsername'],
      startTime: DateTime.parse(json["startTime"]),
      endTime: DateTime.parse(json["endTime"]),
    );
    if (json.containsKey('userUsages'))
      room.userUsages =
          (json['userUsages'] as Map<String, dynamic>).cast<String, int>();
    return room;
  }

  @override
  String toString() =>
      'Room { id: $id, name: $name, hostUsername: $hostUsername }';
}

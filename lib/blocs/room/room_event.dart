import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

class RoomCreate extends RoomEvent {
  final Room room;

  const RoomCreate(this.room);

  @override
  List<Object> get props => [room];

  @override
  String toString() => 'Room Created {Room: $room}';
}

class RoomJoin extends RoomEvent {
  final Room room;

  const RoomJoin(this.room);

  @override
  List<Object> get props => [room];

  @override
  String toString() => 'Room Joined {Room: $room}';
}

class RoomExit extends RoomEvent {
  final Room room;

  const RoomExit(this.room);

  @override
  List<Object> get props => [room];

  @override
  String toString() => 'Room Exitd {Room: $room}';
}

class RoomEnd extends RoomEvent {
  final Room room;

  const RoomEnd(this.room);

  @override
  List<Object> get props => [room];

  @override
  String toString() => 'Room Endd {Room: $room}';
}

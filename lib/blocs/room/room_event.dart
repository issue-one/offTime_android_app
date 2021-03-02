import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
  @override
  List<Object> get props => [];
}

class GetRoom extends RoomEvent {
  final String id;

  GetRoom(this.id);
  @override
  List<Object> get props => [id];
}

class GetRoomHistory extends RoomEvent {}

class LeaveRoom extends RoomEvent {
  final String roomName;

  const LeaveRoom(this.roomName);

  @override
  List<Object> get props => [roomName];
}

class EndRoom extends RoomEvent {
  final Room room;

  const EndRoom(this.room);

  @override
  List<Object> get props => [room];

  @override
  String toString() => 'Room Endd {Room: $room}';
}

import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}
class RoomGet extends RoomEvent{
  final String token;
  final String name;

  RoomGet(this.token, this.name);
  @override
  // TODO: implement props
  List<Object> get props => [token,name];


}
class GetRooms extends RoomEvent{
  final String token;


  GetRooms(this.token);
  @override
  // TODO: implement props
  List<Object> get props => [token];


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

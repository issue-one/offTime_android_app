part of 'join_room_bloc.dart';

class JoinRoomEvent extends Equatable {
  final String roomId;
  const JoinRoomEvent(this.roomId);

  @override
  List<Object> get props => [roomId];
}

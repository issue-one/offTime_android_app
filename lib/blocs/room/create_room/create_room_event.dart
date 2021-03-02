part of 'create_room_bloc.dart';

class CreateRoomEvent extends Equatable {
  final String roomName;

  const CreateRoomEvent(this.roomName);

  @override
  List<Object> get props => [roomName];
}

part of 'join_room_bloc.dart';

abstract class JoinRoomState extends Equatable {
  const JoinRoomState();

  @override
  List<Object> get props => [];
}

class JoinRoomInitial extends JoinRoomState {}

class JoinRoomLoading extends JoinRoomState {}

class JoinRoomFailure extends JoinRoomState {
  final String errMessage;

  const JoinRoomFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

class JoinRoomSuccess extends JoinRoomState {
  final Room room;

  const JoinRoomSuccess(this.room);

  @override
  List<Object> get props => [room];
}

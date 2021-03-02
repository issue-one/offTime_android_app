part of 'ongoing_room_bloc.dart';

abstract class OngoingRoomState extends Equatable {
  const OngoingRoomState();

  @override
  List<Object> get props => [];
}

class OngoingRoomLoading extends OngoingRoomState {}

class OngoingRoomOpSuccess extends OngoingRoomState {}

/* 
class OngoingRoomActive extends OngoingRoomState {
  final String roomId;

  OngoingRoomActive(this.roomId);

  @override
  List<Object> get props => [roomId];
} */
/* 
class OngoingRoomEnded extends OngoingRoomState {
  final String roomId;

  OngoingRoomEnded(this.roomId);

  @override
  List<Object> get props => [roomId];
}
 */
class OngoingRoomOpFailure extends OngoingRoomState {
  final String errMessage;

  OngoingRoomOpFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

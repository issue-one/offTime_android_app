part of 'ongoing_room_bloc.dart';

abstract class OngoingRoomEvent extends Equatable {
  const OngoingRoomEvent();

  @override
  List<Object> get props => [];
}

/* class IncomingOngoingRoomUpdate extends OngoingRoomEvent {
  final Room room;
  const IncomingOngoingRoomUpdate(this.room);
  @override
  List<Object> get props => [room];
}
 */
class UpdateUserUsage extends OngoingRoomEvent {
  final String roomId;
  final int seconds;
  const UpdateUserUsage(this.roomId, this.seconds);
  @override
  List<Object> get props => [seconds];
}

class EndRoomEvent extends OngoingRoomEvent {}

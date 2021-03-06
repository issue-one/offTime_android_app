import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomLoading extends RoomState {}

class RoomsLoadSuccess extends RoomState {
  final Map<String, Room> rooms;

  RoomsLoadSuccess([this.rooms = const {}]);

  @override
  List<Object> get props => [rooms];
}

class RoomOperationFailure extends RoomState {
  final String errMessage;

  RoomOperationFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

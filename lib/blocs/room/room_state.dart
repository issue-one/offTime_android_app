import 'package:equatable/equatable.dart';
import 'package:offTime/models/Room.dart';

class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomLoading extends RoomState {}

class RoomsLoadSuccess extends RoomState {
  final List<Room> rooms;

  RoomsLoadSuccess([this.rooms = const []]);

  @override
  List<Object> get props => [rooms];
}

class RoomOperationFailure extends RoomState {}

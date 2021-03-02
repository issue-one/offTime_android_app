part of 'create_room_bloc.dart';

abstract class CreateRoomState extends Equatable {
  const CreateRoomState();

  @override
  List<Object> get props => [];
}

class CreateRoomInitial extends CreateRoomState {}

class CreateRoomLoading extends CreateRoomState {}

class CreateRoomFailure extends CreateRoomState {
  final String errMessage;

  CreateRoomFailure(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}

class CreateRoomSuccess extends CreateRoomState {
  final Room room;

  CreateRoomSuccess(this.room);

  @override
  List<Object> get props => [room];
}

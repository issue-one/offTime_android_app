import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/models/Room.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final RoomBloc roomBloc;

  CreateRoomBloc(this.roomBloc)
      : assert(roomBloc != null),
        super(CreateRoomInitial());

  @override
  Stream<CreateRoomState> mapEventToState(
    CreateRoomEvent event,
  ) async* {
    yield CreateRoomLoading();
    try {
      final user = roomBloc.userBloc.currentUser;
      final room = await roomBloc.roomRepository
          .createRoomWs(event.roomName, user.username, user.token);
      roomBloc.add(IncomingRoomUpdate(room));
      yield CreateRoomSuccess(room);
    } catch (e) {
      yield CreateRoomFailure(e.toString());
    }
  }
}

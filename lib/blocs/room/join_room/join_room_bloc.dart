import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/models/models.dart';

part 'join_room_event.dart';
part 'join_room_state.dart';

class JoinRoomBloc extends Bloc<JoinRoomEvent, JoinRoomState> {
  final RoomBloc roomBloc;
  JoinRoomBloc(this.roomBloc)
      : assert(roomBloc != null),
        super(JoinRoomInitial());

  @override
  Stream<JoinRoomState> mapEventToState(
    JoinRoomEvent event,
  ) async* {
    yield JoinRoomLoading();
    try {
      final user = roomBloc.userBloc.currentUser;
      final room = await roomBloc.roomRepository
          .joinRoomWs(event.roomId, user.username, user.token);
      yield JoinRoomSuccess(room);
    } catch (e) {
      yield JoinRoomFailure(e.toString());
    }
  }
}

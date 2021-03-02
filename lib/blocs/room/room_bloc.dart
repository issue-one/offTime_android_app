import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/room/room_event.dart';
import 'package:offTime/blocs/room/room_state.dart';
import 'package:offTime/repository/repository.dart';

import '../../off_time.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;
  final UserBloc userBloc;
  final WsConnectionBloc wsBloc;

  RoomBloc(
      {@required this.roomRepository,
      @required this.userBloc,
      @required this.wsBloc})
      : assert(roomRepository != null),
        assert(userBloc != null),
        assert(wsBloc != null),
        super(RoomLoading()) {
    wsBloc.add(Connect());
  }

  factory RoomBloc.loadRooms(
          {@required RoomRepository roomRepository,
          UserBloc userBloc,
          WsConnectionBloc wsBloc}) =>
      RoomBloc(
        roomRepository: roomRepository,
        userBloc: userBloc,
        wsBloc: wsBloc,
      )..add(GetRoomHistory());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    final user = userBloc.currentUser;
    if (event is GetRoom) {
      yield RoomLoading();
      try {
        await roomRepository.getRoom(event.id, user.token);
        yield RoomsLoadSuccess();
      } catch (e) {
        yield RoomOperationFailure(e.toString());
      }
    } else if (event is GetRoomHistory) {
      yield* this._mapEventGetRoomHistory(event);
    } else if (event is EndRoom) {
      throw UnimplementedError();
    } else if (event is LeaveRoom) {
      throw UnimplementedError();
    }
  }

  Stream<RoomState> _mapEventGetRoomHistory(GetRoomHistory event) async* {
    yield RoomLoading();
    try {
      final rooms = await roomRepository.getRoomHistory(userBloc.currentUser);
      yield RoomsLoadSuccess(rooms);
    } catch (e) {
      yield RoomOperationFailure(e.toString());
    }
  }

  @override
  Future<void> close() async {
    this.wsBloc.add(StopConnection());
    await super.close();
  }
}

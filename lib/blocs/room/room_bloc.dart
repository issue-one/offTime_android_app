import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/room/room_event.dart';
import 'package:offTime/blocs/room/room_state.dart';
import 'package:offTime/repository/repository.dart';

import '../../off_time.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;
  final UserBloc userBloc;

  RoomBloc({@required this.roomRepository, @required this.userBloc})
      : assert(roomRepository != null),
        assert(userBloc != null),
        super(RoomLoading());

  factory RoomBloc.loadRooms(
          {@required RoomRepository roomRepository, UserBloc userBloc}) =>
      RoomBloc(roomRepository: roomRepository, userBloc: userBloc)
        ..add(GetRoomHistory());

  User _getCurrentUser() => (userBloc.state as UserLoadSuccess).user;

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    final user = _getCurrentUser();
    if (event is CreateRoom) {
      yield RoomLoading();
      try {
        await roomRepository.createRoomWs(
            user.username, event.roomName, user.token);
        yield RoomsLoadSuccess();
      } catch (e) {
        yield RoomOperationFailure(e.toString());
      }
    } else if (event is GetRoom) {
      yield RoomLoading();
      try {
        await roomRepository.getRoom(event.id, user.token);
        yield RoomsLoadSuccess();
      } catch (e) {
        yield RoomOperationFailure(e.toString());
      }
    } else if (event is GetRoomHistory) {
      yield* this._mapEventGetRoomHistory(event);
    } else if (event is JoinRoom) {
      try {
        Room room =
            await roomRepository.joinRoomWs(user.username, event.roomId);
        yield RoomsLoadSuccess();
      } catch (e) {
        yield RoomOperationFailure(e.toString());
      }
    } else if (event is EndRoom) {
      throw UnimplementedError();
    } else if (event is LeaveRoom) {
      throw UnimplementedError();
    }
  }

  Stream<RoomState> _mapEventGetRoomHistory(GetRoomHistory event) async* {
    yield RoomLoading();
    try {
      final rooms = await roomRepository.getRoomHistory(_getCurrentUser());
      yield RoomsLoadSuccess(rooms);
    } catch (e) {
      yield RoomOperationFailure(e.toString());
    }
  }
}

import 'dart:async';

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
  StreamSubscription _roomUpdateSub;

  RoomBloc(
      {@required this.roomRepository,
      @required this.userBloc,
      @required this.wsBloc})
      : assert(roomRepository != null),
        assert(userBloc != null),
        assert(wsBloc != null),
        super(RoomLoading()) {
    wsBloc.add(Connect());
    wsBloc.listen((wsState) {
      if (wsState == WsState.Connected) {
        _roomUpdateSub = wsBloc.socket.messageStream
            .where((m) => m.event == "roomUpdate")
            .listen((message) =>
                add(IncomingRoomUpdate(Room.fromJson(message.data))));
      }
    });
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
      yield* this._mapEventGetRoom(event);
    } else if (event is GetRoomHistory) {
      yield* this._mapEventGetRoomHistory(event);
    } else if (event is IncomingRoomUpdate) {
      yield* this._mapEventIncomingRoomUpdate(event);
    } else if (event is LeaveRoom) {
      throw UnimplementedError();
    }
  }

  Stream<RoomState> _mapEventGetRoomHistory(GetRoomHistory event) async* {
    yield RoomLoading();
    try {
      final rooms = await roomRepository.getRoomHistory(userBloc.currentUser);
      yield RoomsLoadSuccess(Map.fromIterable(
        rooms,
        key: (r) => r.id,
      ));
    } catch (e) {
      yield RoomOperationFailure(e.toString());
    }
  }

  Stream<RoomState> _mapEventGetRoom(GetRoom event) async* {
    yield RoomLoading();
    try {
      final room =
          await roomRepository.getRoom(event.id, userBloc.currentUser.token);
      Map<String, Room> rooms = Map();
      if (state is RoomsLoadSuccess) {
        rooms.addAll((state as RoomsLoadSuccess)?.rooms);
      }
      rooms[room.id] = room;
      yield RoomsLoadSuccess(rooms);
    } catch (e) {
      yield RoomOperationFailure(e.toString());
    }
  }

  Stream<RoomState> _mapEventIncomingRoomUpdate(
      IncomingRoomUpdate event) async* {
    if (state is RoomsLoadSuccess) {
      try {
        Map<String, Room> rooms = Map.from((state as RoomsLoadSuccess).rooms);
        rooms[event.room.id] = event.room;
        yield RoomsLoadSuccess(rooms);
      } catch (e) {
        yield RoomOperationFailure(e.toString());
      }
    }
  }

  @override
  Future<void> close() async {
    _roomUpdateSub.cancel();
    this.wsBloc.add(StopConnection());
    await super.close();
  }
}

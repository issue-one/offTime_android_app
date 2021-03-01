import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/room/room_event.dart';
import 'package:offTime/blocs/room/room_state.dart';
import 'package:offTime/repository/repository.dart';

import '../../off_time.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;
  final User user;

  RoomBloc({@required this.roomRepository, @required this.user})
      : assert(roomRepository != null),
        super(RoomLoading());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is RoomCreate) {
      yield RoomLoading();
      try {
        await roomRepository.createRoom(event.room);
        yield RoomsLoadSuccess();
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }
    if (event is RoomGet) {
      yield RoomLoading();
      try {
        await roomRepository.getRoom(event.token, event.name);
        yield RoomsLoadSuccess();
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }
    if (event is GetRooms) {
      yield RoomLoading();
      try {
        await roomRepository.getRooms(event.token);
        yield RoomsLoadSuccess();
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }

    if (event is RoomJoin) {
      try {
        Room room = await roomRepository.createRoom(event.room);
        await roomRepository.joinRoom(room);
        yield RoomsLoadSuccess();
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }
    if (event is RoomEnd) {
      try {
        yield RoomLoading();
        yield RoomsLoadSuccess();
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }
    if (event is RoomExit) {
      try {
        yield RoomLoading();
        yield RoomsLoadSuccess();
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/room/room_event.dart';
import 'package:offTime/blocs/room/room_state.dart';
import 'package:offTime/repository/repository.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc({@required this.roomRepository})
      : assert(roomRepository != null),
        super(RoomLoading());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is RoomCreate) {
      yield RoomLoading();
      try {
        // final room = await roomRepository.createRoom(room);
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }

    if (event is RoomJoin) {
      try {
        await roomRepository.createRoom(event.room);
        // final rooms = await roomRepository.joinRoom(RoomEnd(room));
      } catch (e) {
        print(e);
        yield RoomOperationFailure();
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/blocs/room/room.dart';
import 'package:offTime/blocs/room/room_bloc.dart';

part 'ongoing_room_event.dart';
part 'ongoing_room_state.dart';

class OngoingRoomBloc extends Bloc<OngoingRoomEvent, OngoingRoomState> {
  final RoomBloc roomBloc;

  OngoingRoomBloc(this.roomBloc)
      : assert(roomBloc != null),
        super(OngoingRoomOpSuccess());

  @override
  Stream<OngoingRoomState> mapEventToState(
    OngoingRoomEvent event,
  ) async* {
    if (event is EndRoomEvent) {
      yield* this._mapEndRoomEvent(event);
    } else if (event is UpdateUserUsage) {
      yield* this._mapUpdateUserUsageEvent(event);
    }
  }

  @override
  Stream<OngoingRoomState> _mapUpdateUserUsageEvent(
    UpdateUserUsage event,
  ) async* {
    yield OngoingRoomLoading();
    try {
      final user = roomBloc.userBloc.currentUser;
      await roomBloc.roomRepository.updateUserUsageWs(
        event.seconds,
        event.roomId,
        user.username,
        user.token,
      );
      yield OngoingRoomOpSuccess();
    } catch (e) {
      yield OngoingRoomOpFailure(e.toString());
    }
  }

  @override
  Stream<OngoingRoomState> _mapEndRoomEvent(
    EndRoomEvent event,
  ) async* {
    throw UnimplementedError();
  }
/* 
  @override
  Stream<OngoingRoomState> _mapIncomingRoomUpdateEvent(
    IncomingOngoingRoomUpdate event,
  ) async* {
    if (event.room.hasEnded) {
      yield OngoingRoomEnded(event.room);
    } else {
      yield OngoingRoomActive(event.room);
    }
  } */

  @override
  Future<void> close() async {
    await super.close();
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/models/models.dart';

enum LockScreenEvent {
  ON,OFF
}
class Timer{
  int onTime;
  int offTime;

  void incrementOnTime(){
    onTime += 1;
  }
  void incrementOffTime(){
    offTime += 1;
  }
}
//
// class LockScreenBloc extends Bloc<LockScreenEvent,Timer> {
//
//   @override
//   Future<Timer> mapEventToState(LockScreenBloc event) async* {
//     if (event is LockScreenEvent.ON) {
//       yield ;
//       try {
//         // final room = await roomRepository.createRoom(room);
//       } catch (e) {
//         print(e);
//         yield RoomOperationFailure();
//       }
//     }
//
//     if (event is LockScreenEvent.OFF) {
//       try {
//         await roomRepository.createRoom(event.room);
//         // final rooms = await roomRepository.joinRoom(RoomEnd(room));
//       } catch (e) {
//         print(e);
//         yield RoomOperationFailure();
//       }
//     }
//   }
// }
//
//
//

import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
  @override
  List<Object> get props => [];
}

class GetRoom extends RoomEvent {
  final String id;

  GetRoom(this.id);
  @override
  List<Object> get props => [id];
}

class IncomingRoomUpdate extends RoomEvent {
  final Room room;

  IncomingRoomUpdate(this.room);
  @override
  List<Object> get props => [room];
}

class GetRoomHistory extends RoomEvent {}

class LeaveRoom extends RoomEvent {
  final String roomName;

  const LeaveRoom(this.roomName);
  /*         if (event is ConnectionError || event is Disconnected) {
      yield WsState.Connecting;
      await Future.delayed(const Duration(seconds: 1));
      if (this._reconnect) {
        this.add(Reconnect());
      } else {
        yield WsState.NotConnected;
      }
    } else if (event is StopConnection) {
      this._reconnect = false;
      this.socket.close();
      yield WsState.NotConnected;
    } else if (event is Reconnect || event is Connect) {
      if (event is Connect) this._reconnect = true;
      yield WsState.Connecting;
      await this.socket.connect();
      yield WsState.Connected;
    } */
  @override
  List<Object> get props => [roomName];
}

import 'package:offTime/models/models.dart';
import 'package:offTime/data_provider/data_provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WsEvent {}

class Reconnect extends WsEvent {}

class Connect extends WsEvent {}

class StopConnection extends WsEvent {}

class Disconnected extends WsEvent {
  final int status;
  Disconnected(this.status);
}

class ConnectionError extends WsEvent {
  final Object error;
  ConnectionError(this.error);
}

// class ConnectSucceeded extends WsEvent {}

enum WsState { Connected, Connecting, NotConnected }

class WsConnectionBloc extends Bloc<WsEvent, WsState> {
  // void Function(Object) onSocketError;
  final baseUrl = 'ws://192.168.8.117:8080/ws';
  OffTimeSocket socket;
  bool _reconnect = true;

  WsConnectionBloc() : super(WsState.NotConnected) {
    this.socket = OffTimeSocket(
      this.baseUrl,
      onError: this._onErrorHandler,
      onFinish: this._onFinishHandler,
    );
  }

  void _onErrorHandler(OffTimeSocket socket, Object err) {
    this.add(ConnectionError(err));
  }

  void _onFinishHandler(OffTimeSocket socket, int status) {
    print("finished with status $status");
    this.add(Disconnected(status));
  }

  @override
  Stream<WsState> mapEventToState(WsEvent event) async* {
    print("got event: ${event.toString()}");
    print("reconnect?: ${this._reconnect}");
    if (event is ConnectionError) {
      yield WsState.Connecting;
      await Future.delayed(const Duration(seconds: 1));
      if (this._reconnect) {
        this.add(Reconnect());
      } else {
        yield WsState.NotConnected;
      }
    } else if (event is Disconnected) {
      yield WsState.NotConnected;
    } else if (event is StopConnection) {
      this._reconnect = false;
      this.socket.close();
      yield WsState.NotConnected;
    } else if (event is Reconnect || event is Connect) {
      if (event is Connect) this._reconnect = true;
      yield WsState.Connecting;
      await this.socket.connect();
      yield WsState.Connected;
    }
  }

  @override
  Future<void> close() async {
    this.socket.close();
    await super.close();
  }
}

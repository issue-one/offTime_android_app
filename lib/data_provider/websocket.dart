import 'package:web_socket_channel/web_socket_channel.dart' as ws_channel;
import 'package:web_socket_channel/status.dart' as status;
import 'package:offTime/models/models.dart';
import 'dart:convert';

class NotConnectedException implements Exception {}

class OffTimeSocket {
  bool _connected = false;
  ws_channel.WebSocketChannel _channel;
  Stream<dynamic> _streamAsBrodacast;

  final String baseUrl;

  void Function(OffTimeSocket, int) onFinish;
  void Function(OffTimeSocket, Message<dynamic>) onMessage;
  void Function(OffTimeSocket, Object err) onError;

  final Map<String, void Function(OffTimeSocket socket, dynamic data)>
      _eventListeners;

  OffTimeSocket(
    this.baseUrl, {
    Map<String, void Function(OffTimeSocket socket, dynamic data)>
        eventListeners,
    this.onError,
    this.onFinish,
    this.onMessage,
  }) : this._eventListeners = new Map() {
    if (eventListeners != null) this._eventListeners.addAll(eventListeners);
  }

  // private stuff

  void _onData(dynamic dynamicMessage) {
    print(dynamicMessage);
    try {
      final message = Message<dynamic>.fromJson(jsonDecode(dynamicMessage));
      this.onMessage?.call(this, message);
      this._eventListeners[message.event]?.call(this, message.data);
    } catch (e) {
      print("error decoding message $e");
    }
  }

  void _onError(Object err, StackTrace _) {
    print("websocket err: ${err.toString()}");
    this._connected = false;
    this.onError?.call(this, err);
  }

  void _onDone() {
    this._connected = false;
    this.onFinish?.call(this, this._channel.closeCode);
  }

  // public stuff
  bool get isConnected => this._connected;

  /// Get a new instance of the message stream.
  Stream<Message<Map<String, dynamic>>> get messageStream {
    if (!this._connected) throw NotConnectedException();
    return this
        ._streamAsBrodacast
        .map((msg) => Message.fromJson(jsonDecode(msg)));
  }

  Stream<dynamic> getEventStream(String event) {
    if (!this._connected) throw NotConnectedException();
    return this
        .messageStream
        .where((msg) => msg.event == event)
        .map((msg) => msg.data);
  }

  Future<void> connect() async {
    await this.close();
    print("connecting websocket");
    final channel =
        ws_channel.WebSocketChannel.connect(Uri.parse(this.baseUrl));

    // use class methods to allow swapping out handlers during runtime
    this._streamAsBrodacast = channel.stream.asBroadcastStream();
    this._streamAsBrodacast.listen(this._onData,
        onDone: this._onDone, onError: this._onError, cancelOnError: true);
    this._channel = channel;
    this._connected = true;
  }

  Future<void> close() async {
    if (this._connected) {
      await this._channel.sink.close(status.goingAway, "going away");
      this._connected = false;
    }
  }

  Future<void> emit<T>(Message<T> message) async {
    if (!this._connected) throw NotConnectedException();
    print("outgoing message: ${message.data.toString()}");
    final jsonString = message.toJson();
    this._channel.sink.add(jsonString);
  }

  void listen(
    String event,
    void Function(OffTimeSocket socket, dynamic data) listener,
  ) {
    this._eventListeners[event] = listener;
  }

  Future<Message<dynamic>> sendRequest<T>(String requestEvent, T message,
      {String responseEvent, Duration timeout}) async {
    if (!this._connected) throw NotConnectedException();

    if (responseEvent == null) responseEvent = requestEvent;
    if (timeout == null) timeout = Duration(seconds: 3);

    /* // keep a reference if there were any previous listeners;
    final oldListener = this._eventListeners[responseEvent];
    final responseListener = (OffTimeSocket socket, dynamic data) {
      if (oldListener != null) {
        // reinstate old listner
        this._eventListeners[responseEvent] = oldListener;
        oldListener.call(socket, data);
      }
      return data;
    };
    // replace with new listener
    this._eventListeners[responseEvent] = responseListener; */

    await this.emit(Message(requestEvent, message));
    return this
        .messageStream
        .firstWhere((msg) => msg.event == responseEvent)
        .timeout(timeout);
  }
}

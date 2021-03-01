import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/models/models.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OffTime"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: RaisedButton(
                child: Text("Create Room"),
                onPressed: () => print("creating room"),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: RaisedButton(
                child: Text("Join Room"),
                onPressed: () => print("joining room"),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Room History",
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () =>
                            ctx.read<RoomBloc>().add(GetRoomHistory()),
                      ),
                    ],
                  ),
                  Container(
                    child: Expanded(
                      child: BlocBuilder<RoomBloc, RoomState>(
                          builder: (ctx, state) {
                        if (state is RoomsLoadSuccess) {
                          return state.rooms.length > 1
                              ? ListView.builder(
                                  itemCount: state.rooms.length,
                                  itemBuilder: (ctx, index) => ListTile(
                                    title: Text(state.rooms[index].name),
                                  ),
                                )
                              : Center(
                                  child: const Text("Room History Empty"),
                                );
                        } else if (state is RoomOperationFailure) {
                          return Center(
                            child: Text(state.errMessage ?? "Error"),
                          );
                        } else {
                          return Center(
                            child: const Text("Room History Loading..."),
                          );
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// these widgets are for testing the websocket implementation (ignore them)
class WsShowcase extends StatefulWidget {
  static const routeName = 'home';
  @override
  _WsShowcaseState createState() => _WsShowcaseState();
}

class _WsShowcaseState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<WsConnectionBloc, WsState>(builder: (ctx, state) {
          switch (state) {
            case WsState.Connected:
              return const Text("Connected");
            case WsState.NotConnected:
              return const Text("Not Connected");
            default:
              return const Text("Connecting...");
          }
        }),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<WsConnectionBloc, WsState>(
                  builder: (ctx, state) => RaisedButton(
                    child: const Text("Connect"),
                    onPressed: () =>
                        ctx.read<WsConnectionBloc>().add(Connect()),
                  ),
                ),
                BlocBuilder<WsConnectionBloc, WsState>(
                  builder: (ctx, state) => RaisedButton(
                    child: const Text("Disconnect"),
                    onPressed: () =>
                        ctx.read<WsConnectionBloc>().add(StopConnection()),
                  ),
                ),
              ],
            ),
            ResponseRequestShowcase()
          ],
        ),
      ),
    );
  }
}

class EmitListenShowcase extends StatefulWidget {
  EmitListenShowcase({Key key}) : super(key: key);

  @override
  _EmitListenShowcaseState createState() => _EmitListenShowcaseState();
}

class _EmitListenShowcaseState extends State<EmitListenShowcase> {
  final _formKey = GlobalKey<FormState>();
  final List<String> messageHistory = [];
  String outgoingMessage = "";

  void _onMessage(dynamic message) {
    setState(() {
      this.messageHistory.add(message);
    });
  }

  void _changeOutgoingMessage(String message) {
    print("class message: ${this.outgoingMessage}");
    setState(() {
      this.outgoingMessage = message;
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Expanded(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: this._formKey,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: "",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Message to send'),
                    onSaved: (value) {
                      print("onSaved: $value");
                      this._changeOutgoingMessage(value);
                    },
                  ),
                ),
                BlocBuilder<WsConnectionBloc, WsState>(
                  builder: (ctx, state) => RaisedButton(
                    onPressed: state == WsState.Connected
                        ? () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              ctx
                                  .read<WsConnectionBloc>()
                                  .socket
                                  .emit(Message("echo", this.outgoingMessage));
                            }
                          }
                        : null,
                    child: const Text("SEND"),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<WsConnectionBloc, WsState>(
              builder: (ctx, state) => state == WsState.Connected
                  ? StreamBuilder<Message<dynamic>>(
                      stream: ctx.read<WsConnectionBloc>().socket.messageStream,
                      initialData: Message("waiting", "waiting on stream"),
                      builder: (ctx, snapshot) => Center(
                        child: Column(
                          children: [
                            if (snapshot.hasData) ...[
                              Text(snapshot.data.event),
                              Text(snapshot.data.data.toString()),
                            ] else if (snapshot.hasError)
                              Text(snapshot.error.toString()),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: const Text("Not connected."),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResponseRequestShowcase extends StatefulWidget {
  ResponseRequestShowcase({Key key}) : super(key: key);

  @override
  _ResponseRequestShowcaseState createState() =>
      _ResponseRequestShowcaseState();
}

class _ResponseRequestShowcaseState extends State<ResponseRequestShowcase> {
  final _formKey = GlobalKey<FormState>();
  final List<String> messageHistory = [];
  String outgoingMessage = "";
  String incomingMessage = "";

  void _changeOutgoingMessage(String message) {
    print("outgoing message: ${this.outgoingMessage}");
    setState(() {
      this.outgoingMessage = message;
    });
  }

  void _setIncomingMessage(String message) {
    print("incoming message: ${this.outgoingMessage}");
    setState(() {
      this.incomingMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Form(
            key: this._formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: "",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a message';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Message to send'),
                    onSaved: (value) {
                      print("onSaved: $value");
                      this._changeOutgoingMessage(value);
                    },
                  ),
                ),
                BlocBuilder<WsConnectionBloc, WsState>(
                  builder: (ctx, state) => RaisedButton(
                    onPressed: state == WsState.Connected
                        ? () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              ctx
                                  .read<WsConnectionBloc>()
                                  .socket
                                  .sendRequest(
                                      "echo", this.outgoingMessage, "echo")
                                  .then((response) {
                                this._setIncomingMessage(
                                    response.data.toString());
                              });
                            }
                          }
                        : null,
                    child: const Text("SEND"),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Text(this.incomingMessage),
          ),
        ],
      ),
    );
  }
}

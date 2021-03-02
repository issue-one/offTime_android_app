import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/blocs/room/room.dart';
import 'package:offTime/models/models.dart';
import 'package:offTime/screens/screens.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _homePageScaffoldKey = GlobalKey();
  bool _bottomSheetOpen = false;
  void _showBottomSheet(Widget Function(BuildContext) widgetBuilder) {
    if (_bottomSheetOpen) return;
    setState(() {
      _bottomSheetOpen = true;
    });
    this
        ._homePageScaffoldKey
        .currentState
        .showBottomSheet(
          widgetBuilder,
          elevation: 299,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        )
        .closed
        .then((_) => setState(() {
              _bottomSheetOpen = false;
            }));
  }

  @override
  Widget build(BuildContext ctx) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CreateRoomBloc(
            ctx.read<RoomBloc>(),
          ),
        ),
        BlocProvider(
          create: (ctx) => JoinRoomBloc(
            ctx.read<RoomBloc>(),
          ),
        ),
      ],
      child: Scaffold(
        key: this._homePageScaffoldKey,
        appBar: AppBar(
          title: BlocBuilder<WsConnectionBloc, WsState>(
            builder: (ctx, state) => state == WsState.Connected
                ? const Text("OffTime")
                : const Text("Connecting..."),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: RaisedButton(
                  child: Text("Create Room"),
                  onPressed: () => _showBottomSheet(
                    (ctx) => CreateRoomSheet(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                  child: Text("Join Room"),
                  onPressed: () => _showBottomSheet(
                    (ctx) => JoinRoomSheet(),
                  ),
                ),
              ),
            ),
            // -  -  - room history section
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
                      //  -  -  - room history list
                      child: Expanded(
                        child: BlocBuilder<RoomBloc, RoomState>(
                            builder: (ctx, state) {
                          if (state is RoomsLoadSuccess) {
                            final keys = state.rooms.keys.toList();
                            return state.rooms.length > 0
                                ? ListView.builder(
                                    itemCount: state.rooms.length,
                                    itemBuilder: (ctx, index) {
                                      final room = state.rooms[keys[index]];
                                      if (room.hasEnded) {
                                        ListTile(
                                          title: Text(room.name),
                                        );
                                      }
                                      return ListTile(
                                        title: Text(room.name),
                                        trailing: const Text("Ongoing"),
                                        onTap: () {
                                          Navigator.pushNamed(
                                            ctx,
                                            RoomDetailsPage.routeName,
                                            arguments:
                                                RoomDetailsRouteArgs(room.id),
                                          );
                                        },
                                      );
                                    })
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
      ),
    );
  }
}

class CreateRoomSheet extends StatefulWidget {
  CreateRoomSheet({Key key}) : super(key: key);

  @override
  _CreateRoomSheetState createState() => _CreateRoomSheetState();
}

class _CreateRoomSheetState extends State<CreateRoomSheet> {
  final _formKey = GlobalKey<FormState>();
  String _roomName;
  @override
  Widget build(BuildContext ctx) {
    return Container(
        // height: 275,
        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Form(
          key: _formKey,
          child: BlocConsumer<CreateRoomBloc, CreateRoomState>(
            listener: (oldState, newState) {
              if (newState is CreateRoomSuccess) {
                Navigator.pushNamed(
                  ctx,
                  RoomDetailsPage.routeName,
                  arguments: RoomDetailsRouteArgs(newState.room.id),
                );
              }
            },
            builder: (ctx, state) => Column(
              children: [
                const Text("Create room"),
                if (state is CreateRoomFailure)
                  Text(
                    state.errMessage,
                  ),
                TextFormField(
                  initialValue: "",
                  onSaved: (value) => setState(() => this._roomName = value),
                  decoration: const InputDecoration(labelText: 'Room name'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Uhh, name can't be empty";
                    }
                    return null;
                  },
                ),
                RaisedButton(
                    child: const Text("Create"),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        ctx
                            .read<CreateRoomBloc>()
                            .add(CreateRoomEvent(this._roomName));
                      }
                    })
              ],
            ),
          ),
        ));
  }
}

class JoinRoomSheet extends StatefulWidget {
  @override
  _JoinRoomSheetState createState() => _JoinRoomSheetState();
}

class _JoinRoomSheetState extends State<JoinRoomSheet> {
  final _formKey = GlobalKey<FormState>();
  String _roomId;
  @override
  Widget build(BuildContext ctx) {
    return Container(
        // height: 275,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Form(
            key: _formKey,
            child: BlocConsumer<JoinRoomBloc, JoinRoomState>(
              listener: (oldState, newState) {
                if (newState is JoinRoomSuccess) {
                  Navigator.pushNamed(
                    ctx,
                    RoomDetailsPage.routeName,
                    arguments: RoomDetailsRouteArgs(_roomId),
                  );
                }
              },
              builder: (ctx, state) => Column(
                children: [
                  const Text("Join room"),
                  if (state is JoinRoomFailure)
                    Text(
                      state.errMessage,
                    ),
                  TextFormField(
                    initialValue:
                        (ctx.read<RoomBloc>().state as RoomsLoadSuccess)
                                .rooms
                                .values
                                .firstWhere(
                                  (r) => !r.hasEnded,
                                  orElse: () => null,
                                )
                                ?.id ??
                            "",
                    onSaved: (value) => setState(() => this._roomId = value),
                    decoration: const InputDecoration(labelText: 'RoomId'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Uhh, id can't be empty";
                      }
                      return null;
                    },
                  ),
                  RaisedButton(
                      child: const Text("Join"),
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();
                          ctx
                              .read<JoinRoomBloc>()
                              .add(JoinRoomEvent(this._roomId));
                        }
                      })
                ],
              ),
            ),
          ),
        ));
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
                                  .sendRequest("echo", this.outgoingMessage)
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

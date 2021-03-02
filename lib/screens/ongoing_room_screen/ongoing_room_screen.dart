import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/blocs/room/room.dart';

class OngoingRoomRouteArgs {
  final String roomId;

  const OngoingRoomRouteArgs(this.roomId);
}

class OngoingRoomScreen extends StatefulWidget {
  static const routeName = "/room";
  final String roomId;

  const OngoingRoomScreen(this.roomId, {Key key}) : super(key: key);
  @override
  _OngoingRoomScreenState createState() => _OngoingRoomScreenState();
}

class _OngoingRoomScreenState extends State<OngoingRoomScreen> {
  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (ctx, state) {
        /* BlocBuilder<WsConnectionBloc, WsState>(
            builder: (ctx, state) => state == WsState.Connected
                ? const Text("OffTime")
                : const Text("Connecting..."),
          ) */

        if (state is! RoomsLoadSuccess)
          return Scaffold(
            appBar: AppBar(
              title: const Text("Error"),
            ),
            body: Center(
              child: const Text("Unable to load rooms."),
            ),
          );

        final room = (state as RoomsLoadSuccess).rooms[widget.roomId];
        if (room == null)
          return Scaffold(
            appBar: AppBar(
              title: const Text("Room Not Found"),
            ),
            body: Center(
              child: Text("Unable to find room under id ${widget.roomId}"),
            ),
          );
        return Scaffold(
          appBar: AppBar(
            title: BlocBuilder<WsConnectionBloc, WsState>(
                builder: (ctx, state) => Column(
                      children: [
                        Text(room.name),
                        if (state != WsState.Connected)
                          Text(
                            "Connecting...",
                            style: Theme.of(ctx).textTheme.subtitle2,
                          ),
                      ],
                    )),
          ),
          body: Center(
            child: Text(room.toString()),
          ),
        );
      },
    );
  }
}

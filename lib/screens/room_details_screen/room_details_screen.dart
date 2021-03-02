import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/blocs/room/room.dart';

class RoomDetailsRouteArgs {
  final String roomId;

  const RoomDetailsRouteArgs(this.roomId);
}

class RoomDetailsPage extends StatefulWidget {
  static const routeName = "/room";
  final String roomId;

  const RoomDetailsPage(this.roomId, {Key key}) : super(key: key);
  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
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
              child: Column(
            children: [
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
                            "Users",
                          ),
                          /*   IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () =>
                                ctx.read<RoomBloc>().add(GetRoomHistory()),
                          ), */
                        ],
                      ),
                      Container(
                        //  -  -  - user usages list
                        child: Expanded(
                          child: BlocBuilder<UserBloc, UserState>(
                              builder: (ctx, state) {
                            if (state is UserLoadSuccess) {
                              final user = state.user;
                              final usagesSorted = room.userUsages.entries
                                  .where((e) => e.key != user.username)
                                  .toList();
                              usagesSorted
                                  .sort((a, b) => a.value.compareTo(b.value));
                              return usagesSorted.length > 0
                                  ? ListView.builder(
                                      itemCount: usagesSorted.length,
                                      itemBuilder: (ctx, index) {
                                        /* final user = state.rooms[keys[index]];
                                        if (room.hasEnded) {
                                          ListTile(
                                            title: Text(room.name),
                                          );
                                        } */
                                        return ListTile(
                                          title: Text(usagesSorted[index].key),
                                          trailing: Text(Duration(
                                                  microseconds:
                                                      usagesSorted[index].value)
                                              .toString()),
                                        );
                                      })
                                  : Center(
                                      child: const Text("No users."),
                                    );
                            } else {
                              return Center(
                                child: const Text("Something went wrong..."),
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
          )),
        );
      },
    );
  }
}

import 'dart:io';
import 'package:meta/meta.dart';
import 'package:offTime/data_provider/data_provider.dart';
import 'package:offTime/models/models.dart';

class RoomRepository {
  final RoomDataProvider roomDataProvider;
  final RoomDataProviderWs wsProvider;

  Map<String, Room> rooms;
  RoomRepository({@required this.roomDataProvider, @required this.wsProvider})
      : assert(roomDataProvider != null);

  Future<Room> createRoom(Room room) async {
    return await roomDataProvider.createRoom(room);
  }

  Future<Room> joinRoom(Room room) async {
    return await roomDataProvider.joinRoom(room);
  }

  Future<Room> getRoom(String roomId) async {
    var room = this.rooms[roomId];
    if (room == null) throw Exception("room not found");
  }

  Future<Room> createRoomWs(Room input) async {
    final room = await wsProvider.createRoom(input.hostUsername, input.name);
    this.rooms[room.id] = room;
    return room;
  }

  Future<Room> joinRoomWs(Room room) async {
    return await roomDataProvider.joinRoom(room);
  }
}

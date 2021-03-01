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

  Future<Room> getRoom(String token, String name) async {
    return await roomDataProvider.getRoom(token, name);
  }

  Future<List<Room>> getRooms(String token) async {
    return await roomDataProvider.getRooms(token);
  }

  Future<Room> joinRoom(Room room) async {
    return await roomDataProvider.joinRoom(room);
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

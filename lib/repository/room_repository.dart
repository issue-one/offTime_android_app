import 'dart:io';
import 'package:meta/meta.dart';
import 'package:offTime/blocs/room/room.dart';
import 'package:offTime/data_provider/data_provider.dart';
import 'package:offTime/models/models.dart';

class RoomRepository {
  final RoomDataProvider roomDataProvider;
  final RoomDataProviderWs wsProvider;

  // Map<String, Room> rooms = Map();

  RoomRepository({@required this.roomDataProvider, @required this.wsProvider})
      : assert(roomDataProvider != null);

  Future<Room> createRoom(Room room) async {
    return await roomDataProvider.createRoom(room);
  }

  Future<Room> getRoom(String id, String authToken) async {
    return await roomDataProvider.getRoom(authToken, id);
  }

  Future<List<Room>> getRoomHistory(User user) async {
    return await roomDataProvider.getRoomsHistory(user.username, user.token);
  }

  Future<Room> joinRoom(Room room, String authToken) async {
    return await roomDataProvider.joinRoom(room);
  }

  Future<Room> createRoomWs(
      String roomName, String username, String authToken) async {
    final room = await wsProvider.createRoom(username, roomName);
    // this.rooms[room.id] = room;
    return room;
  }

  Future<Room> joinRoomWs(String roomId, String authToken) async {
    return await wsProvider.joinRoom(roomId, authToken);
  }
}

import 'dart:io';
import 'package:meta/meta.dart';
import 'package:offTime/data_provider/data_provider.dart';
import 'package:offTime/data_provider/room_data_provider.dart';
import 'package:offTime/models/models.dart';

class RoomRepository {
  final RoomDataProvider roomDataProvider;
  RoomRepository({@required this.roomDataProvider})
      : assert(roomDataProvider != null);

  Future<Room> createRoom(Room room) async {
    return await roomDataProvider.createRoom(room);
  }
  Future<Room> getRoom(String token, String name) async {
    return await roomDataProvider.getRoom(token,name);
  }
  Future<List<Room>> getRooms(String token) async {
    return await roomDataProvider.getRooms(token);
  }

  Future<Room> joinRoom(Room room) async {
    return await roomDataProvider.joinRoom(room);
  }
}

import 'package:offTime/data_provider/websocket.dart';
import 'package:offTime/models/models.dart';

class RoomDataProviderWs {
  // final baseUrl = 'ws://192.168.8.117:8080/ws';
  final OffTimeSocket socket;

  RoomDataProviderWs({this.socket});
  //TODO 409 CONFLICTS 422 UNPROCESSABLE Password

  Future<Room> createRoom(String username, String roomName) async {
    var response = await this.socket.sendRequest(
      "createRoom",
      <String, dynamic>{"username": username, "roomName": roomName},
    ) as Message<Map<String, dynamic>>;
    switch (response.data["code"]) {
      case 200:
        return Room.fromJson(response.data["message"]);
        break;
      default:
        throw Exception("got resonse ${response.toString()}");
    }
  }

  Future<Room> joinRoom(
    String roomId,
    String username,
    String authToken,
  ) async {
    var response = await this.socket.sendRequest(
      "joinRoom",
      <String, dynamic>{"username": username, "roomID": roomId},
    ) as Message<Map<String, dynamic>>;
    switch (response.data["code"]) {
      case 200:
        return Room.fromJson(response.data["message"]);
        break;
      default:
        throw Exception(
            "Unable to join room: ${response.data["message"].toString()}");
    }
  }

  Future<void> updateUserUsageWs(
    int usageSeconds,
    String roomId,
    String username,
    String authToken,
  ) async {
    var response = await this.socket.sendRequest(
      "updateRoomUsage",
      <String, dynamic>{
        "username": username,
        "roomID": roomId,
        "usageSeconds": usageSeconds
      },
    ) as Message<Map<String, dynamic>>;
    switch (response.data["code"]) {
      case 200:
        break;
      case 400:
        throw Exception("Unable to update usage: room not found");
      default:
        throw Exception(
            "Unable to update: ${response.data["message"].toString()}");
    }
  }
}

import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
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
      String roomId, String username, String authToken) async {
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
}

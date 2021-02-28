import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:offTime/models/models.dart';

class RoomDataProvider {
  final _baseUrl = "http://10.0.2.2:8080";
  final http.Client httpClient;

  RoomDataProvider({this.httpClient});
  //TODO 409 CONFLICTS 422 UNPROCESSABLE Password

  Future<Room> createRoom(Room room) async {
    final http.Response response = await httpClient.post(
      '$_baseUrl/rooms',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'roomName': room.name,
      }),
    );
    //TODO 409 CONFLICT
    if (response.statusCode != 200) {
      throw Exception('Failed to add User.');
    }
    print("Successful");
    return Room.fromJson(jsonDecode(response.body));
  }

  Future<Room> joinRoom(Room room) async {
    final http.Response response = await httpClient.post(
      '$_baseUrl/rooms',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'roomName': room.name,
      }),
    );
    //TODO 409 CONFLICT
    if (response.statusCode != 200) {
      throw Exception('Failed to add User.');
    }
    print("Successful");
    return Room.fromJson(jsonDecode(response.body));
  }
}

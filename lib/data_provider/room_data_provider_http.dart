import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:offTime/models/models.dart';

class RoomDataProvider {
  final _baseUrl = "http://192.168.43.41:8080";
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

  Future<List<Room>> getRoomsHistory(String username, String token) async {
    final response = await httpClient.get(
      '$_baseUrl/users/$username/roomHistory',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      List<Room> allRooms = new List<Room>();
      final rooms = jsonDecode(response.body);
      for (var item in rooms) {
        Room room = Room.fromJson(item);
        allRooms.add(room);
      }
      return allRooms;
    } else {
      throw Exception('Failed to load rooms: code ${response.statusCode}');
    }
  }

  Future<Room> getRoom(String token, String name) async {
    final response = await httpClient.get(
      '$_baseUrl/rooms/{$name}',
      headers: {
        HttpHeaders.authorizationHeader: "Bearer " + token,
        HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
      },
    );

    if (response.statusCode == 200) {
      return Room.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load room');
    }
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

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
  Future<List<Room>> getRooms(String token) async{
    
     final response= await httpClient.get('$_baseUrl/rooms',
         headers: {HttpHeaders.authorizationHeader: "Bearer " + token,
           HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
         },
     );

     if(response.statusCode == 200){
       List<Room> allRooms= new List<Room>();
       final rooms= jsonDecode(response.body);
       var items =await rooms['items'] as List;
       for (var item in items) {
         Room room =Room.fromJson(item);
         allRooms.add(room);
         
       }
       return allRooms;

     } else{
       throw Exception('Failed to load rooms');
     }
   }
   Future<Room> getRoom(String token, String name) async{
    
     final response= await httpClient.get('$_baseUrl/rooms/{$name}',
         headers: {HttpHeaders.authorizationHeader: "Bearer " + token,
           HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
         },
     );

     if(response.statusCode == 200){     
       return Room.fromJson(jsonDecode(response.body));

     } else{
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

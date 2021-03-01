import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:offTime/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:offTime/models/user_update_input.dart';


class UserDataProvider{
   final _baseUrl="http://192.168.1.4:8080";
   final http.Client httpClient;

  UserDataProvider({this.httpClient});
  //TODO 409 CONFLICTS 422 UNPROCESSABLE Password
   Future<User> createUser(UserInput userInput) async {
      
     final http.Response response = await httpClient.put(
       '$_baseUrl/users/${userInput.username}',
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(<String, dynamic>{
         'password': userInput.password,
         'email': userInput.email,

       }),
     );
      //TODO 409 CONFLICT
     if (response.statusCode != 200) {
       throw Exception('Failed to add User.');
     }
     print("yes");
     return User.fromJson(jsonDecode(response.body));
   }
   Future<String> postToken(UserInput userInput) async {
     print("${userInput.username}");
     var uri = Uri.parse(_baseUrl);
      print(uri.host);
      print(uri.port);
     print("here");
     final response = await httpClient.post(
       Uri.http('192.168.1.4:8080' ,'/token-auth'),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body: jsonEncode(<String, String>{
         'password': userInput.password,
         'username': userInput.username,
        }),
     );
     print("here");
     switch(response.statusCode){
       case 200:
         return jsonDecode(response.body)['token'];
       case 403:
         throw Exception('Invalid user');
       default:
         throw Exception('Error ${response.statusCode}');
     }
   }
   Future<User> getUser(String username, String token) async{
    
     final response= await httpClient.get('$_baseUrl/users/$username',
         headers: {HttpHeaders.authorizationHeader: "Bearer " + token,
           HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
         },
     );

     if(response.statusCode == 200){
       final user= jsonDecode(response.body) ;
       return User( username: user['username'],
      createdAt: DateTime.parse(user['createdAt']),
      updatedAt: DateTime.parse(user['updatedAt']),
      email: user['email'],
      pictureURL: user['pictureURL']== null ? null : user['pictureURL'],
      roomHistory: (user['roomHistory'] as List).map((item) => item as String).toList(),
      token: token
      );

     } else{
       throw Exception('Failed to load User $username');
     }
   }
   Future<String> refreshToken(String token) async {
     final response= await httpClient.get('$_baseUrl/token-auth-refresh',
       headers: {HttpHeaders.authorizationHeader: "Bearer" + token,
         HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
       },
     );

     if(response.statusCode == 200){
       return jsonDecode(response.body)['auth_token'];

     } else{
       throw Exception('Failed to load User ');
     }
   }
   Future<User> updateUser(User user, UserUpdateInput userUpdateInput ) async {
     final http.Response response = await httpClient.patch(
       '$_baseUrl/${user.username}',
       headers: {HttpHeaders.authorizationHeader: "Bearer" + user.token,
         HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8"

       },

       body: jsonEncode(<String, dynamic>{
         'email': userUpdateInput.email,
         'password': userUpdateInput.password,
         'pictureURL': userUpdateInput.pictureURL,
       }),
     );
     if(response.statusCode == 200){
       final user= jsonDecode(response.body) ;
       return User.fromJson(user);

     } else{
       throw Exception('Failed to load User ${user.username}');
     }
   }
   Future<void> deleteUser(User user) async{
     final response= await httpClient.delete('$_baseUrl/users/${user.username}',
         headers: {HttpHeaders.authorizationHeader: "Bearer" + user.token,

         },
     );
     if(response.statusCode !=200){
       throw Exception('Failed to delete App History');
     }

   }
   Future<String> putPicture(User user, File file) async{

     var uri = Uri.parse(_baseUrl+"/users"+user.username+"/picture");
     var request = http.MultipartRequest('PUT', uri)
       ..files.add(await http.MultipartFile.fromPath(
           'image', file.path,
           contentType: MediaType('image', lookupMimeType(file.path))));
     request.headers['authorization'] = "Bearer "+ user.token;

     http.Response responseBody = await http.Response.fromStream(await request.send());
     if(responseBody.statusCode !=200){
       throw Exception('Failed to delete App History');
     }
     return jsonDecode(responseBody.body);

   }
  Future<void> addToSharedPreferences(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("authInfo",[user.username,user.token]);
}
   Future<List<String>>getSharedPreferences() async {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      List<String> userAuth= sharedPreferences.getStringList("authInfo");
      print(userAuth);
      return userAuth;
}




}


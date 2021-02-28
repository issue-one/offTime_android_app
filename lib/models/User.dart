import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String email ;
  final String pictureURL;
  final List<String> roomHistory;
  final String token;

  User({this.username, this.createdAt, this.updatedAt, this.email, this.pictureURL, this.roomHistory, this.token});

  @override
  List<Object> get props => [username,createdAt,updatedAt,email,pictureURL,roomHistory,token];
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User( username: json['username'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      email: json['email'],
      pictureURL: json['pictureURL']== null ? null : json['pictureURL'],
      roomHistory: (json['roomHistory'] as List).map((item) => item as String).toList(),);
  }

  
  @override
  String toString() {
    return 'User[username=$username, createdAt=$createdAt, updatedAt=$updatedAt, email=$email, pictureURL=$pictureURL, roomHistory=$roomHistory, token=$token ]';
  }

  





}

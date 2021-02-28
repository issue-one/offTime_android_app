import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserInput extends Equatable {
  final String password;
  final String email ;
  final String username;
  UserInput({this.email,@required this.password,this.username});
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }
  @override
  String toString() {
    return 'CreateUserInput[email=$email, password=$password, username=$username]';
  }
  @override
  List<Object> get props => [password,email];







}

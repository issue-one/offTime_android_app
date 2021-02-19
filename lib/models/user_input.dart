import 'package:equatable/equatable.dart';

class UserInput extends Equatable {
  final String password;
  final String email ;
  final String username;
  UserInput({this.email,this.password,this.username});
  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }
  @override
  String toString() {
    return 'CreateUserInput[email=$email, password=$password, ]';
  }
  @override
  List<Object> get props => [password,email];







}

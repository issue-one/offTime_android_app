import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}
class UserLoading extends UserState{}

class UserLoadSuccess extends UserState{
  final User user;
  UserLoadSuccess({this.user});
  @override
  List<Object> get props => [user];
}
class UserLoadFailure extends UserState{
  
}
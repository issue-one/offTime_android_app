import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

class UserAuthenticationState extends Equatable{
  const UserAuthenticationState();

  @override
  List<Object> get props => [];
}
class UserAuthenticating extends UserAuthenticationState{}

class UserAuthenticationSuccess extends UserAuthenticationState{
  final User user;
  UserAuthenticationSuccess({this.user});
  @override
  List<Object> get props => [user];
}
class UserAuthenticationFailure extends UserAuthenticationState{}
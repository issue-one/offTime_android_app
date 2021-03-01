import 'package:equatable/equatable.dart';
import 'package:offTime/models/models.dart';

class UserAuthenticationState extends Equatable {
  const UserAuthenticationState();

  @override
  List<Object> get props => [];
}

class UserNotAuthenticated extends UserAuthenticationState {}

class UserAuthenticationWaiting extends UserAuthenticationState {}

class UserAuthenticationSuccess extends UserAuthenticationState {
  final User user;
  UserAuthenticationSuccess({this.user});
  @override
  List<Object> get props => [user];
}

class UserAuthenticationFailure extends UserAuthenticationState {
  final String errMessage;
  UserAuthenticationFailure({this.errMessage});
  @override
  List<Object> get props => [errMessage];
}

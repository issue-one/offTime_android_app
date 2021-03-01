import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:offTime/models/models.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class AccountDeleteRequested extends UserEvent {
  final String username;
  final String token;

  const AccountDeleteRequested({@required this.username, @required this.token}) : assert(username != null && token!=null);

  @override
  List<Object> get props => [username, token];
}
class AccountUpdateRequested extends UserEvent {
  final String username;
  final String token;
  final UserUpdateInput userUpdateInput;

  const AccountUpdateRequested({@required this.username, @required this.token, @required this.userUpdateInput}) : assert(username != null && token!=null && userUpdateInput!=null);

  @override
  List<Object> get props => [username, token,userUpdateInput];
}
class AddPictureRequested extends UserEvent {
  final User user;
  final File file;

  const AddPictureRequested({@required this.user, @required this.file}) : assert(user != null && file != null);

  @override
  List<Object> get props => [user, file];
}

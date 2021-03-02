import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'blocs.dart';
import 'package:meta/meta.dart';
import 'package:offTime/blocs/authentication/authentication_bloc.dart';
import 'package:offTime/blocs/authentication/authentication_state.dart';
import 'package:offTime/blocs/user/user_event.dart';
import 'package:offTime/blocs/user/user_state.dart';
import 'package:offTime/models/User.dart';

import 'package:offTime/repository/repository.dart';

import '../../off_time.dart';

class UserSettingBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final UserBloc userBloc;

  UserSettingBloc({@required this.userRepository,@required this.userBloc}):assert(userRepository != null),assert(userBloc != null), super(UserLoading());

  Stream<UserState> mapEventToState(UserEvent event) async* {
    
      if (event is AccountUpdateRequested) {
        yield* _mapAccountUpdateRequestedToState(event);
      } else if (event is AddPictureRequested) {
        yield* _mapAddPictureRequestedToState(event);
      } else if (event is AccountDeleteRequested) {
        yield* _mapAccountDeleteRequestedToState(event);
      }
   
  }

  Stream<UserState> _mapAccountUpdateRequestedToState(
      AccountUpdateRequested event) async* {
    yield UserLoading();
    try {
      final user =
          await userRepository.updateUser(userBloc.currentUser, event.userUpdateInput);

      yield UserLoadSuccess(user: user);
    } catch (_) {
      yield UserLoadFailure();
    }
  }

  Stream<UserState> _mapAccountDeleteRequestedToState(
      AccountDeleteRequested event) async* {
    yield UserLoading();
    try {
      await userRepository.deleteUser(userBloc.currentUser);
      yield UserLoadFailure();
      
    } catch (_) {
      yield UserLoadSuccess();
    }
  }

  Stream<UserState> _mapAddPictureRequestedToState(
      AddPictureRequested event) async* {
    yield UserLoading();
    try {
      await userRepository.putPicture(userBloc.currentUser, event.file);
      final user =
          await userRepository.getUser(userBloc.currentUser.username, userBloc.currentUser.token);
      yield UserLoadSuccess(user: user);
    } catch (_) {
      yield UserLoadFailure();
    }
  }
}

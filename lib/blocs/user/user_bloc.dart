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

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final UserAuthenticationBloc userAuthenticationBloc;

  UserBloc(
      {@required this.userRepository, @required this.userAuthenticationBloc})
      : assert(userRepository != null),
        super(userAuthenticationBloc.state is UserAuthenticationSuccess
            ? UserLoadSuccess(
                user:
                    (userAuthenticationBloc.state as UserAuthenticationSuccess)
                        .user)
            : UserLoadFailure());

  User get currentUser => (state as UserLoadSuccess).user;

  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (userAuthenticationBloc.state is UserAuthenticationSuccess) {
      if (event is AccountUpdateRequested) {
        yield* _mapAccountUpdateRequestedToState(event);
      } else if (event is AddPictureRequested) {
        yield* _mapAddPictureRequestedToState(event);
      } else if (event is AccountDeleteRequested) {
        yield* _mapAccountDeleteRequestedToState(event);
      }
    } else {
      yield UserLoadFailure();
    }
  }

  Stream<UserState> _mapAccountUpdateRequestedToState(
      AccountUpdateRequested event) async* {
    yield UserLoading();
    try {
      final user =
          await userRepository.updateUser(event.user, event.userUpdateInput);

      yield UserLoadSuccess(user: user);
    } catch (_) {
      yield UserLoadFailure();
    }
  }

  Stream<UserState> _mapAccountDeleteRequestedToState(
      AccountDeleteRequested event) async* {
    yield UserLoading();
    try {
      await userRepository.deleteUser(event.user);

      yield UserLoadSuccess();
    } catch (_) {
      yield UserLoadFailure();
    }
  }

  Stream<UserState> _mapAddPictureRequestedToState(
      AddPictureRequested event) async* {
    yield UserLoading();
    try {
      await userRepository.putPicture(event.user, event.file);
      final user =
          await userRepository.getUser(event.user.username, event.user.token);
      yield UserLoadSuccess(user: user);
    } catch (_) {
      yield UserLoadFailure();
    }
  }
}

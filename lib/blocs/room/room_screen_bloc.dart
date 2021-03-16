// import 'dart:html';

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum ScreenEvent { RoomScreenLock, RoomScreenUnlock }

class ScreenBloc extends Bloc<ScreenEvent, int> {
  ScreenBloc() : super(0);

  @override
  Stream<int> mapEventToState(ScreenEvent event) async* {
    try {
      if (event == ScreenEvent.RoomScreenUnlock) {
        yield state + 1;
      } else {
        yield state;
      }
    } catch (e) {
      print(e);
    }
  }
}

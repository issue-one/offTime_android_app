import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/room/room_screen_bloc.dart';

class TimeCounter extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScreenBloc>(
      lazy: false,
      create: (_) => ScreenBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TimeCounterPage(),
      ),
    );
  }
}

class TimeCounterPage extends StatefulWidget {
  static const platform = MethodChannel("com.example.offtime_android_app");
  @override
  _TimeCounterPageState createState() {
    return _TimeCounterPageState();
  }
}

class _TimeCounterPageState extends State<TimeCounterPage> {
  Timer _timer;
  int secondsPassedTotal = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  static const Duration duration = const Duration(seconds: 1);

  void giveState() async {
    print("--------Print from giveState-----------");

    bool screenOn;
    try {
      screenOn = await TimeCounterPage.platform.invokeMethod("giveState");
      if (screenOn == true) {
        context.read<ScreenBloc>().add(ScreenEvent.RoomScreenUnlock);
      } else {
        context.read<ScreenBloc>().add(ScreenEvent.RoomScreenLock);
      }
    } catch (e) {
      print(e);
    }
    print("--- $screenOn ---");
    // return state;
  }

  void handleTickforTotalTimer() {
    setState(() {
      secondsPassedTotal = secondsPassedTotal + 1;
      seconds = secondsPassedTotal % 60;
      minutes = secondsPassedTotal ~/ 60;
      hours = secondsPassedTotal ~/ (60 * 60);
    });
  }

  void startTimer() {
    _timer = new Timer.periodic(duration, (Timer timer) {
      handleTickforTotalTimer();
      giveState();
    });
  }

  void endTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // start both timers... RoomActive
    if (_timer == null) {
      startTimer();
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Text("Total Room time"),
            Text("$hours hours $minutes min $seconds sec"),
            FlatButton(child: Text("End Timer"), onPressed: () => endTimer()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("On Screen Time"),
                BlocBuilder<ScreenBloc, int>(
                  builder: (context, value) {
                    int onScreenseconds = value % 60;
                    int onScreenminutes = value ~/ 60;
                    int onScreenhours = value ~/ (60 * 60);
                    return Text(
                        "$onScreenhours hours $onScreenminutes min $onScreenseconds sec");
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Off Screen Time"),
                BlocBuilder<ScreenBloc, int>(
                  builder: (context, value) {
                    int secondsPassedOffline = secondsPassedTotal - value;
                    int secPassedOffline = secondsPassedOffline % 60;
                    int minutesPassedOffline = secondsPassedOffline ~/ 60;
                    int hoursPassedOffline = secondsPassedOffline ~/ (60 * 60);
                    return Text(
                        "$hoursPassedOffline hours $minutesPassedOffline min $secPassedOffline sec");
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

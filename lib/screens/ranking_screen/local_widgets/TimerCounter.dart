
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimerPage extends StatefulWidget {
  static const platform = MethodChannel("com.example.flutter_app");
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<TimerPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  void giveState() async{
    print("--------Print from giveState-----------");

    String state;
    try{
      state = await TimerPage.platform.invokeMethod("giveState");
    }catch(e){
      print(e);
    }
    print(state);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    giveState();
    // setState(() { _notification = state; });
  }

  // int _counter = 0;
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  void startTimer() {
    _timer = new Timer.periodic(
      Duration(seconds: 1),
          (Timer timer) => setState(
            () {
          if (seconds < 0) {
            timer.cancel();
          } else {
            seconds = seconds + 1;
            if (seconds > 59) {
              minutes += 1;
              seconds = 0;
              if (minutes > 59) {
                hours += 1;
                minutes = 0;
              }
            }
          }
        },
      ),
    );
  }

  void endTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            FlatButton(
                child: Text("Start Timer"), onPressed: () {
              startTimer();
              giveState();
            }),
            Text(""),
            Text("$hours hours $minutes min $seconds sec"),
            FlatButton(child: Text("End Timer"), onPressed: () => endTimer()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("On Screen Time"),
                Text(""),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Off Screen Time"),
                Text(""),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
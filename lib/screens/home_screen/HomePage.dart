import 'package:flutter/material.dart';
import 'package:offTime/screens/ranking_screen/local_widgets/RoomInfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFEDD5D0),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          // TODO: we should extract this appBar and place it under widgets so that all of us can use it
          title: Text('OffTime'),
          expandedHeight: 210,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: RoomInfo(),
          ),
        ),
        SliverFillRemaining(
          child: Center(
            child: Column(
              children: [
                FlatButton(onPressed: null, child: Text("Create Room")),
                FlatButton(onPressed: null, child: Text("Join Room")),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

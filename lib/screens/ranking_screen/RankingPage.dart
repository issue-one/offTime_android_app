import 'package:flutter/material.dart';
import 'package:offTime/screens/ranking_screen/local_widgets/RoomInfo.dart';

import 'local_widgets/UserRank.dart';

class RankingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Ranking'),
            expandedHeight: 210,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: RoomInfo(),
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              // return UserRank();
            },
          )
        ],
      ),
    );
  }
}

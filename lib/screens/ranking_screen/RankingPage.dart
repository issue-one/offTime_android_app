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
            // TODO: we should extract this appBar and place it under widgets so that all of us can use it
            title: const Text('Ranking'),

            expandedHeight: 210,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: RoomInfo(),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
            UserRank(),
          ]))
        ],
      ),
    );
  }
}

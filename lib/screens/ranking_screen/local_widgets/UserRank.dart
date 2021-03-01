import 'package:flutter/material.dart';

class UserRank extends StatelessWidget {
  final String username;
  final ImageProvider imageProvider;
  final String timespent;

  const UserRank({this.imageProvider, this.timespent, this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: imageProvider,
          ),
          Text(
            "$username",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "$timespent",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

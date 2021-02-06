import 'package:flutter/material.dart';

class UserInRoom extends StatelessWidget {
  const UserInRoom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/istock.jpg"),
          ),
          Icon(Icons.ac_unit),
          Text(
            "@username of user",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "20:23",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

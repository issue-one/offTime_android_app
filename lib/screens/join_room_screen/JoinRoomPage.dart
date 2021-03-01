import 'package:flutter/material.dart';
import 'package:offTime/models/User.dart';

class JoinRoomPage extends StatefulWidget {
  static String routeName = "/joinRoomPage";

  @override
  _JoinRoomPageState createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends State<JoinRoomPage> {
  @override
  Widget build(BuildContext context) {
    // User user = ModalRoute.of(context).settings.arguments;
    String password = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Join Room"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop(context, "Successfully created Room");
            },
          )
        ],
      ),
      body: Form(
        // key: _formKey,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(
                    Icons.person_outline,
                    size: 30,
                  ),
                ),
                onSaved: (value) {
                  setState(
                    () {
                      password = value;
                    },
                  );
                },
              ),
              // Add password here too?
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: FlatButton(child: Text("Request"), onPressed: () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

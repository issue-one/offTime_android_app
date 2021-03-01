import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/blocs.dart';
import 'package:offTime/models/models.dart';
import 'package:offTime/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRoomPage extends StatefulWidget {
  static String routeName = "/createRoomPage";

  @override
  _CreateRoomPageState createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  List<String> userAuth=[];
  void initState() async{
    super.initState();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
        userAuth= sharedPreferences.getStringList("authInfo");  
        });
    

  }
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    final _formKey = GlobalKey<FormState>();

    String _roomName = "";

    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) { return Scaffold(
        appBar: AppBar(
          title: Text("Create Room"),
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
          key: _formKey,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Room Name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Room Name',
                    icon: Icon(
                      Icons.person_outline,
                      size: 30,
                    ),
                  ),
                  onSaved: (value) {
                    setState(
                      () {
                        _roomName = value;
                      },
                    );
                  },
                ),
                // Add password here too?
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: MyElevatedButton(
                        title: "Create Room",
                        myOnPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            // print("herekndks");
                            Room(hostUsername: user.username, name: _roomName);

                            // final UserAuthenticationEvent event= LoginRequested(
                            // userInput: UserInput( username: _user["username"], password: _user["password"]));
                            // print(_user);
                            // BlocProvider.of<UserAuthenticationBloc>(context).add(event);
                            // Navigator.of(context).pushNamedAndRemoveUntil(MyStatefulWidget.routeName,(route)=>false );
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );});
   
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/authentication/authentication.dart';
import 'package:offTime/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../off_time.dart';
import '../screens.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(      
        leading: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        title: Text('Settings'),
        titleSpacing: 0.5,
        
      ),
      body: Container(
        child: Column(
          children: [
          Center(child: Image.asset("assets/images/clock.jpg"),),
           SettingsPageForm(),
        ],),
      ),
    );
  }
}
class SettingsPageForm extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPageForm> {
  final _formKey = GlobalKey<FormState>();
  String username='';
  String token='';

  final Map<String, dynamic> _user = {};
  @override
  void initState() {
    super.initState();
    _loadSharedPreference();
  }

  _loadSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getStringList("authInfo")[0];
      token = prefs.getStringList("authInfo")[1];
      print(prefs);
    });
    //print(offTimeUsername);
  }

   @override
  Widget build(BuildContext ctx) {
    return Container(
      color: Theme.of(ctx).primaryColor,
      child: BlocConsumer<UserBloc, UserState>(
        listener: (ctx, state) {
          if (state is UserAuthenticationSuccess)
            Navigator.of(ctx).pushNamedAndRemoveUntil(MyStatefulWidget.routeName, (route) => false);
        },
        builder: (ctx, authState) => Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Form(
          key: _formKey,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                if (authState is UserAuthenticationFailure)
                  
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Username';
                      }else if (value.length<5) {
                        return 'Username should be atleast 5 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Userame',
                        icon: Icon(
                          Icons.person_outline,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),),
                    onSaved: (value) {
                      setState(() {
                        this._user["username"] = value;
                      });
                    }),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Email';
                      }else if(!EmailValidator.validate(value)){
                        return 'Enter proper email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(
                        Icons.email_outlined,
                        size: 30,
                        color: Theme.of(context).accentColor,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                    ),
                    onSaved: (value) {
                      setState(() {
                        this._user["email"] = value;
                      });
                    }),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(
                          Icons.lock_outline,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),
                        ),
                    onSaved: (value) {
                      setState(() {
                        this._user["password"] = value;
                      });
                    }),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: MyElevatedButton(
                        title: "Sign Up",
                        myOnPressed: () {
                          final form = _formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            final UserEvent event =
                                AccountUpdateRequested(
                                  username: username ,
                                  token: token,
                                    userUpdateInput: UserUpdateInput(
                                        
                                        password: _user["password"],
                                        email: _user["email"]));

                            BlocProvider.of<UserBloc>(context)
                                .add(event);
                          }
                        },
                        navigation: false,
                      ),
                    )),
          Center(
            child:
                BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
              listener: (ctx, state) {
                if (state is UserNotAuthenticated)
                  Navigator.of(ctx).pushNamedAndRemoveUntil(
                      IntroPage.routeName, (route) => false);
              },
              child: FlatButton(
                onPressed: () =>
                    BlocProvider.of<UserAuthenticationBloc>(context)
                        .add(LogoutRequested()),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/authentication/authentication.dart';
import 'package:offTime/blocs/user/user.dart';
import 'package:offTime/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../off_time.dart';
import '../screens.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool edit=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(      
        leading: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
            onTap: () {
              setState(() {
                edit=!edit;              
                            });
            },
            child: Icon(
            Icons.edit,
            size: 26.0,
        ),
      )
    ),
        ],      
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        title: Text('Settings'),
        titleSpacing: 0.5,
        
      ),
      body: Container(
        child: Column(
          children: [
          Center(child: Image.asset("assets/images/clock.jpg", height: MediaQuery.of(context).size.height*0.4,)),
          edit? Profile(): SettingsPageForm(),
        ],),
      ),
    );
  }
}
class Profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<UserBloc,UserState>(
        builder: (context,state) =>
        state is UserLoadSuccess? 
        
        Container(
      color: Theme.of(context).primaryColor,
      child:  Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
              
            
                TextFormField(
                    enabled: false,
                    initialValue: "${state.user.username}",
                    decoration: InputDecoration(
                        labelText: 'Username',
                        icon: Icon(
                          Icons.person_outline,
                          size: 30,
                          color: Theme.of(context).accentColor,
                        
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).accentColor),
                      ),),
                    ),
                TextFormField(
                    enabled: false,
                    initialValue: "${state.user.email}",
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
                    ),
                TextFormField(
                    enabled: false,
                    initialValue: "***************",
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
                    
                    ),
                
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
           Center(
            child:
                BlocListener<UserSettingBloc, UserState>(
              listener: (ctx, state) {
                if (state is UserLoadFailure)
                  Navigator.of(ctx).pushNamedAndRemoveUntil(
                      IntroPage.routeName, (route) => false);
              },
              child: FlatButton(
                onPressed: () =>
                    BlocProvider.of<UserSettingBloc>(context)
                        .add(AccountDeleteRequested(user: state.user)),

                child: Text(
                  "Delete Account",
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
      ):Text("Erro loading Info about user")     
      )
    
    
    );
    
  }

}
class SettingsPageForm extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPageForm> {
  final _formKey = GlobalKey<FormState>();
  

  final Map<String, dynamic> _user = {};
  

   @override
  Widget build(BuildContext ctx) {
    return Container(
      color: Theme.of(ctx).primaryColor,
      child:  Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Form(
          key: _formKey,
          child: Container(

            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                
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
                BlocBuilder<UserSettingBloc,UserState>(
                  builder:(context,state)=> Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: MyElevatedButton(
                          title: "Save Changes",
                          myOnPressed: () {
                            final form = _formKey.currentState;
                            if (form.validate()) {
                              form.save();
                              final UserEvent event =
                                  AccountUpdateRequested(
                                    user: (state as UserLoadSuccess).user,
                                      userUpdateInput: UserUpdateInput(
                                          
                                          password: _user["password"],
                                          email: _user["email"]));

                              BlocProvider.of<UserSettingBloc>(context)
                                  .add(event);
                            }
                          },
                          navigation: false,
                        ),
                      ))
                ),
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
        ),);
      
  }
}

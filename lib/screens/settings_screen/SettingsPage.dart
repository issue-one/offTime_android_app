import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/authentication/authentication.dart';
import 'package:offTime/blocs/user/user.dart';
import 'package:offTime/widgets/theme/theme.dart';

import '../../off_time.dart';
import '../screens.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = 'settings';

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
            child: !edit? Icon(
            Icons.edit  ,
            size: 30.0,
            color: Theme.of(context).accentColor,
        ):Icon(
            Icons.person_outline  ,
            size: 30.0,
            color: Theme.of(context).accentColor,
        ) ,
      )
    ),
        ],      
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        title: Text('Settings', style: Theme.of(context).textTheme.headline2),
        titleSpacing: 0.5,
        
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
            children: [
            Center(child: Image.asset("assets/images/clock.jpg", height: MediaQuery.of(context).size.height*0.3,)),
            !edit? Profile(): SettingsPageForm(),
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
            child: Column(
              children: [
              
            
                TextFormField(
                  
                    enabled: false,
                    initialValue: "${state.user.username}",
                    decoration: InputDecoration(
                      labelStyle: Theme.of(context).textTheme.overline,
                      hintStyle: Theme.of(context).textTheme.overline,
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
                      labelStyle: Theme.of(context).textTheme.overline,
                      hintStyle: Theme.of(context).textTheme.overline,
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
                      labelStyle: Theme.of(context).textTheme.overline,
                      hintStyle: Theme.of(context).textTheme.overline,
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
           BlocBuilder<AppThemeBloc, ThemeData>(
              builder: (ctx,state) =>
                SwitchListTile(
                  subtitle: (state == MyTheme.lightAppTheme)? Text('Light Theme', style: Theme.of(context).textTheme.headline3): Text('Dark Theme', style: Theme.of(context).textTheme.headline3),
                title:  Text('Theme', style: Theme.of(context).textTheme.headline2),
                value:(state == MyTheme.lightAppTheme)? true: false  ,onChanged: (bool value) {
                    if(value){
                      context.read<AppThemeBloc>().add(ThemeEvent.lightTheme);
                    }else{
                      context.read<AppThemeBloc>().add(ThemeEvent.darkTheme);
                    }
                    
               },
              secondary: const Icon(Icons.lightbulb_outline),
          ),
                ),       
                
          Center(
            heightFactor: 1.5,
            child:
                BlocListener<UserAuthenticationBloc, UserAuthenticationState>(
              listener: (ctx, state) {
                if (state is UserNotAuthenticated)
                  Navigator.of(ctx).pushNamedAndRemoveUntil(
                      IntroPage.routeName, (route) => false);
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                child: MyElevatedButton(
                  title: "Log Out",
                  myOnPressed: () =>
                      BlocProvider.of<UserAuthenticationBloc>(context)
                        .add(LogoutRequested()),
                      

                  navigation: false,
                  ),
              ),
            ),
          ),
          Center(
            heightFactor: 1.5,
            child: Text("Or", style: Theme.of(context).textTheme.headline3),),
          
           Center(
             
            child:
                BlocListener<UserSettingBloc, UserState>(
              listener: (ctx, state) {
                if (state is UserLoadFailure)
                  Navigator.of(ctx).pushNamedAndRemoveUntil(
                      IntroPage.routeName, (route) => false);
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.75,
                child: MyElevatedButton(
                  title: "Delete Account",
                  myOnPressed: () =>
                      BlocProvider.of<UserSettingBloc>(context)
                          .add(AccountDeleteRequested(user: state.user)),
                      

                  navigation: false,
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
      child:  BlocBuilder<UserBloc,UserState>(
        builder: (context,state) =>
        state is UserLoadSuccess? (
        Container(
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
                        labelStyle: Theme.of(context).textTheme.overline,
                      hintStyle: Theme.of(context).textTheme.overline,
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
                    obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle: Theme.of(context).textTheme.overline,
                      hintStyle: Theme.of(context).textTheme.overline,
                          
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

                      
                   BlocListener<UserSettingBloc, UserState>(
                listener: (ctx, state) {
                  if(state is UserLoadFailure) print(state);
                  if (state is UserLoadSuccess)
                    Navigator.of(ctx).pushNamedAndRemoveUntil(
                        SettingsPage.routeName, (route) => false);
                },
                     child: Padding(
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
                                        user: (state).user,
                                          userUpdateInput: UserUpdateInput(
                                              
                                              password: _user["password"],
                                              email: _user["email"]));

                                  BlocProvider.of<UserSettingBloc>(context)
                                      .add(event);
                                }
                              },
                              navigation: false,
                            ),
                          )),
                   ),
                   
                  
            
                ],
              ),
            ),
          ),
          )): Text("")
      ),);
      
  }
}

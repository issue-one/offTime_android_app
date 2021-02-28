import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/off_time.dart';
import 'package:offTime/screens/sign_up_screen/SignUpPage.dart';

class LoginPage extends StatelessWidget{
  static const routeName = 'Login';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50.0),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(child: Text("Login"),),
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: LoginPageForm()),
            Text("Don't have an account?"),
            GestureDetector(
              onTap: (){ Navigator.pushNamed(context, SignUpPage.routeName);},
              child: Text("Sign Up")
            )
        ],
      ));
  }

}


class LoginPageForm extends StatefulWidget {
  


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPageForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _user = {};
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Form(
        key: _formKey,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            
            children: [
              TextFormField(
                  
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Userame', icon: Icon(Icons.person_outline, size: 30,)),
                  onSaved: (value) {
                    setState(() {
                      this._user["username"] = value;
                    });
                  }),
              TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock_outline, size: 30,), fillColor: Theme.of(context).accentColor),
                  onSaved: (value) {
                    setState(() {
                      this._user["password"] = value;
                    });
                  }),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width* 0.75,
                  child: MyElevatedButton(title: "Login",myOnPressed: (){
                      final form = _formKey.currentState;
                      if (form.validate()) {
                          form.save();
                          print("herekndks");
                      final UserAuthenticationEvent event= LoginRequested(
                      userInput: UserInput( username: _user["username"], password: _user["password"]));
                      print(_user);
                      BlocProvider.of<UserAuthenticationBloc>(context).add(event);
                        
  }
                  },navigation: false,),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


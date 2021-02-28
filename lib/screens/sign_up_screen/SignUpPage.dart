import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/off_time.dart';

class SignUpPage extends StatelessWidget{
  static const routeName = 'Sign Up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        padding: EdgeInsets.all(50.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(child: Text("Sign Up", style: Theme.of(context).textTheme.headline2,),),
            Expanded(child: SignUpPageForm()),
            Text("Already have an account?", style: Theme.of(context).textTheme.headline2,),
            GestureDetector(
                onTap: (){ Navigator.pushNamed(context, LoginPage.routeName);},
                child: Text("Login",  style: Theme.of(context).textTheme.headline2,)
              )
              
              
          ],
        )),
    );
  }

}


class SignUpPageForm extends StatefulWidget {
  


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPageForm> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _user = {};
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Scaffold(
        
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
                        return 'Enter Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email_outlined, size: 30,), ),
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
                    decoration: InputDecoration(labelText: 'Password', icon: Icon(Icons.lock_outline, size: 30,), fillColor: Colors.amber),
                    onSaved: (value) {
                      setState(() {
                        this._user["password"] = value;
                      });
                    }),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width* 0.75,
                    child: MyElevatedButton(title: "Sign Up",myOnPressed: (){
                        final form = _formKey.currentState;
                        if (form.validate()) {
                            form.save();
                        final UserAuthenticationEvent event= SignUpRequested(
                        userInput: UserInput( username: _user["username"], password: _user["password"], email: _user["email"]));
                      
                        BlocProvider.of<UserAuthenticationBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(MyStatefulWidget.routeName,(route)=>false );
                          
  }
                    },navigation: false,),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


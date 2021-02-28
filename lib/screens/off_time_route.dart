import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/screens/screens.dart';

import '../off_time.dart';

class Load extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserAuthenticationBloc, UserAuthenticationState>(
      builder: (context, userAuthenticationState) {
        return Column(children: [
          Image.asset(""),
          LinearProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),),
        ],);},
        listener: (context,userAuthenticationState){
          if(userAuthenticationState is UserAuthenticationSuccess){
            Navigator.of(context).pushNamedAndRemoveUntil(MyStatefulWidget.routeName,(route)=>false);
          }else{
            Navigator.of(context).pushNamedAndRemoveUntil(IntroPage.routeName,(route)=>false);
          }
        },
        
        
        )
         
      );



    
  }

} 

class OffTimeAppRoute {
  

  static Route generateRoute(RouteSettings settings) {
    
    
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => Load());
    }
    if(settings.name == IntroPage.routeName){
      return MaterialPageRoute(builder: (context) => IntroPage() );
    }

    if (settings.name == LoginPage.routeName) {

      return MaterialPageRoute(
          builder: (context) => LoginPage(

          ));
    }
    if (settings.name == SignUpPage.routeName) {

      return MaterialPageRoute(
          builder: (context) => SignUpPage(

          ));
    }
    if(settings.name == MyStatefulWidget.routeName){
      return MaterialPageRoute(builder:(context) => MyStatefulWidget(),);

    }



    return MaterialPageRoute(builder: (context) => IntroPage());
  }
}


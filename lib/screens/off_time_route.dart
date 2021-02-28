import 'package:flutter/material.dart';
import 'package:offTime/screens/screens.dart';



class OffTimeAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => IntroPage());
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



    return MaterialPageRoute(builder: (context) => IntroPage());
  }
}


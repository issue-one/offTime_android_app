import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/room/room.dart';
import 'package:offTime/off_time.dart';

import '../off_time.dart';

class Load extends StatefulWidget {
  @override
  _LoadState createState() => _LoadState();
}

class _LoadState extends State<Load> {
  void initState() {
    super.initState();
    BlocProvider.of<UserAuthenticationBloc>(context).add(IsLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UserAuthenticationBloc, UserAuthenticationState>(
      builder: (context, userAuthenticationState) {
        return Column(
          children: [
            Image.asset("assets/images/clock.jpg"),
            LinearProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
            ),
          ],
        );
      },
      listener: (context, userAuthenticationState) {
        print(userAuthenticationState);
        if (userAuthenticationState is UserNotAuthenticated) {
          Navigator.pushReplacementNamed(context, IntroPage.routeName);
        }else if (userAuthenticationState is UserAuthenticationFailure) {
          Navigator.pushReplacementNamed(context, IntroPage.routeName);
        }else if (userAuthenticationState is UserOffLine) {
          Navigator.pushReplacementNamed(context, MyStatefulWidget.routeName);
        } else if (userAuthenticationState is UserAuthenticationSuccess) {
          Navigator.pushReplacementNamed(context, MyStatefulWidget.routeName);
        }
      },
    ));
  }
}

class OffTimeAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => Load());
    }
    if (settings.name == IntroPage.routeName) {
      return MaterialPageRoute(builder: (context) => IntroPage());
    }
    if (settings.name == SettingsPage.routeName) {
      return MaterialPageRoute(builder: (context) => SettingsPage());
    }

    if (settings.name == LoginPage.routeName) {
      return MaterialPageRoute(builder: (context) => LoginPage());
    }
    if (settings.name == SignUpPage.routeName) {
      return MaterialPageRoute(builder: (context) => SignUpPage());
    }
    if (settings.name == MyStatefulWidget.routeName) {
      return MaterialPageRoute(
        builder: (context) => MyStatefulWidget(),
      );
    }
    if (settings.name == RoomDetailsPage.routeName) {
      RoomDetailsRouteArgs args = settings.arguments;
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
          create: (ctx) => OngoingRoomBloc(ctx.read<RoomBloc>()),
          child: RoomDetailsPage(args.roomId),
        ),
      );
    }

    return MaterialPageRoute(builder: (context) => IntroPage());
  }
}

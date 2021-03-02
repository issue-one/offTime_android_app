/// Flutter code sample for BottomNavigationBar
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/screens/analytics_screen/AnalyticsPage.dart';
import 'package:offTime/screens/home_screen/HomePage.dart';
import 'package:offTime/screens/off_time_route.dart';
import 'package:offTime/screens/settings_screen/SettingsPage.dart';
import 'package:offTime/off_time.dart';

import 'package:offTime/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository(
    userDataProvider: UserDataProvider(
      httpClient: http.Client(),
    ),
  );
  runApp(
    MyApp(
      userRepository: userRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final AnalyticsRepository analyticsRepository =
      AnalyticsRepository(AnalyticsDataProvider());
  final AnalyticsToServerRepository analyticsToServerRepository =
      AnalyticsToServerRepository(onlineAnalyticsProvider(http.Client()));
  /*final UserRepository userRepository = UserRepository(
    userDataProvider: UserDataProvider(
      httpClient: http.Client(),),);

   */
  final UserRepository userRepository;

  MyApp({@required this.userRepository}) : assert(userRepository != null);

  @override
  Widget build(BuildContext ctx) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => WsConnectionBloc()),
        BlocProvider(create: (ctx) => AppThemeBloc()),
        BlocProvider(
            create: (ctx) => UserAuthenticationBloc.checkIfLoggedIn(
                userRepository: userRepository)),
        BlocProvider(
            create: (ctx) => UserBloc(
                userAuthenticationBloc: ctx.read<UserAuthenticationBloc>(),
                userRepository: userRepository)),
        BlocProvider<AnalyticsOnlineBloc>(
            create: (BuildContext ctx) =>
                AnalyticsOnlineBloc(analyticsToServerRepository)),
        BlocProvider<AnalyticsBloc>(
          create: (BuildContext ctx) => AnalyticsBloc(analyticsRepository),
        ),
        BlocProvider<RoomBloc>(
          // lazy: false,
          create: (ctx) {
            final wsBloc = BlocProvider.of<WsConnectionBloc>(ctx);
            return RoomBloc.loadRooms(
              userBloc: ctx.read<UserBloc>(),
              wsBloc: wsBloc,
              roomRepository: RoomRepository(
                roomDataProvider: RoomDataProvider(
                  httpClient: http.Client(),
                ),
                wsProvider: RoomDataProviderWs(
                  socket: wsBloc.socket,
                ),
              ),
            );
          },
        ),
      ],
      child: RepositoryProvider.value(
        value: this.userRepository,
        child: BlocBuilder<AppThemeBloc, ThemeData>(
          builder: (ctx, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: _title,
              theme: state,
              onGenerateRoute: OffTimeAppRoute.generateRoute,
            );
          },
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  static const routeName = 'homeApp';
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final pages = [
    HomePage(),
    AnalyticsPage(),
    SettingsPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
        title: Text('${appBarNames[_selectedIndex]}'),
      ),

       */
      body: pages[_selectedIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        // fabLocation: BubbleBottomBarFabLocation.end, //new
        hasNotch: true, //new
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: [
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(
                Icons.dashboard,
                color: Theme.of(context).accentColor,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Theme.of(context).accentColor,
              ),
              title: Text("Home", )),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(
                Icons.stairs_outlined,
                color: Theme.of(context).accentColor,
              ),
              activeIcon: Icon(
                Icons.stairs_outlined,
                color: Theme.of(context).accentColor,
              ),
              title: Text("Analysis")),
          BubbleBottomBarItem(
              backgroundColor: Theme.of(context).accentColor,
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Theme.of(context).accentColor,
              ),
              title: Text("Settings")),
        ],
        // inkColor: Colors.black12,
      ),
    );
  }
}

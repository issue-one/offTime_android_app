/// Flutter code sample for BottomNavigationBar
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/Bussiness%20Logic/Analytics%20Online/analytics_online_bloc.dart';
import 'package:offTime/Bussiness%20Logic/Analytics/analytics_bloc.dart';
import 'package:offTime/screens/analytics_screen/AnalyticsPage.dart';
import 'package:offTime/screens/home_screen/HomePage.dart';
import 'package:offTime/screens/off_time_route.dart';
import 'package:offTime/screens/settings_screen/SettingsPage.dart';
import 'package:offTime/off_time.dart';

import 'package:offTime/widgets/widgets.dart';
import 'package:http/http.dart' as http;


import 'Data/Data Providers/analytics_data.dart';
import 'Data/Data Providers/analytics_to_server_data_provider.dart';
import 'Data/Repository/analytics_repository.dart';
import 'Data/Repository/analytics_to_server_repostiory.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final AnalyticsRepository analyticsRepository =
  AnalyticsRepository(AnalyticsDataProvider());
  final AnalyticsToServerRepository analyticsToServerRepository =
  AnalyticsToServerRepository(onlineAnalyticsProvider(http.Client()));
  final UserRepository userRepository = UserRepository(
    userDataProvider: UserDataProvider(
      httpClient: http.Client(),),);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
            UserAuthenticationBloc(userRepository: userRepository)),

        BlocProvider(create: (context) => AppThemeBloc()),

        BlocProvider<AnalyticsOnlineBloc>(
            create: (BuildContext context) =>
                AnalyticsOnlineBloc(analyticsToServerRepository)),
        BlocProvider<AnalyticsBloc>(
          create: (BuildContext context) => AnalyticsBloc(analyticsRepository),
        ),
      ],
      child: RepositoryProvider.value(
        value: this.userRepository,
        child: BlocBuilder<AppThemeBloc, ThemeData>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: true,
              title: _title,
              theme: state,
              home: MyStatefulWidget(),
              onGenerateRoute: OffTimeAppRoute.generateRoute,
            );
          },

        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  static const routeName = 'homeApp';

  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<String> appBarNames = ['Off Time', 'Analysis', ' Settings'];
  List<Widget> pages = [
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
        hasNotch: true,
        //new
        hasInk: true,
        //new, gives a cute ink effect
        inkColor: Colors.black12,
        //optional, uses theme color if not specified
        items: [
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.stairs_outlined,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.stairs_outlined,
                color: Colors.deepPurple,
              ),
              title: Text("Analysis")),
          BubbleBottomBarItem(
              backgroundColor: Colors.indigo,
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.indigo,
              ),
              title: Text("Settings")),
        ],
        // inkColor: Colors.black12,
      ),
    );
  }
}






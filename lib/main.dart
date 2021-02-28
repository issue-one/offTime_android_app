/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets and the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].
//
// ![A scaffold with a bottom navigation bar containing three bottom navigation
// bar items. The first one is selected.](https://flutter.github.io/assets-for-api-docs/assets/material/bottom_navigation_bar.png)

import 'package:flutter/material.dart';
import 'package:offTime/screens/analytics_screen/AnalyticsPage.dart';
import 'package:offTime/screens/home_screen/HomePage.dart';

import 'package:offTime/screens/settings_screen/SettingsPage.dart';
import 'package:offTime/off_time.dart';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository(
    userDataProvider: UserDataProvider(
      httpClient: http.Client(),),);
  runApp(


    MultiProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeBloc()),
        BlocProvider(create: (context) => UserAuthenticationBloc(userRepository: userRepository)..add(IsLoggedIn())),
        BlocProvider(create: (context) => UserBloc(userAuthenticationBloc: UserAuthenticationBloc(userRepository: userRepository) , userRepository: userRepository)),

      ],
      child: MyApp(userRepository: userRepository,),

    ),
  );
}

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  final UserRepository userRepository;

  MyApp({@required this.userRepository})
      : assert(userRepository != null);


     

  @override
  Widget build(BuildContext context) {
    
    return RepositoryProvider.value(
      value: this.userRepository,
      child:  BlocBuilder<UserAuthenticationBloc, UserAuthenticationState>(
      builder: (context, userAuthenticationState) {
          
          return BlocBuilder<AppThemeBloc, ThemeData>(
              builder: (context, state) {
                return  MaterialApp(
           debugShowCheckedModeBanner: false,
          title: _title,
          theme: state,
           onGenerateRoute: 
           OffTimeAppRoute.generateRoute ,


        );
                
              });
        
      })
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
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
              title: const Text('Off Time '),
            ),
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






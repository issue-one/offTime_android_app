import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/blocs/Analytics/analytics_bloc.dart';
import 'package:offTime/blocs/AnalyticsOnline/analytics_online_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AnalyticsTime {
  DailyAnalytics,
  WeeklyAnalystics,
  MonthlyAnalytics,
  YearlyAnalytics
}

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  Widget buildBottomSheet(BuildContext buildContext) {
    return Container();
  }

  String offTimeUsername = '';
  String tokenKey = '';

  String queryPageName = 'Daily';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSharedPreference();
  }

  _loadSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      offTimeUsername = prefs.getStringList("authInfo")[0];
      tokenKey = prefs.getStringList("authInfo")[1];
    });
    //print(offTimeUsername);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Analytics'),
          actions: [
            PopupMenuButton<AnalyticsTime>(
              onSelected: (AnalyticsTime time) {
                setState(() {
                  if (time == AnalyticsTime.DailyAnalytics) {
                    queryPageName = 'Daily';
                    BlocProvider.of<AnalyticsBloc>(context)
                        .add(AnalyticsEvent.AnalyticsDailyRequested);
                  } else if (time == AnalyticsTime.WeeklyAnalystics) {
                    queryPageName = 'Weekly';
                    BlocProvider.of<AnalyticsBloc>(context)
                        .add(AnalyticsEvent.AnalyticsWeeklyRequested);
                  } else if (time == AnalyticsTime.MonthlyAnalytics) {
                    queryPageName = 'Monthly';
                    BlocProvider.of<AnalyticsBloc>(context)
                        .add(AnalyticsEvent.AnalyticsMonthlyRequested);
                  } else if (time == AnalyticsTime.YearlyAnalytics) {
                    queryPageName = 'Yearly';
                    BlocProvider.of<AnalyticsBloc>(context)
                        .add(AnalyticsEvent.AnalyticsYearlyRequested);
                  }
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<AnalyticsTime>>[
                const PopupMenuItem<AnalyticsTime>(
                    value: AnalyticsTime.DailyAnalytics, child: Text('Daily')),
                const PopupMenuItem<AnalyticsTime>(
                    value: AnalyticsTime.WeeklyAnalystics,
                    child: Text('Weekly')),
                const PopupMenuItem<AnalyticsTime>(
                    value: AnalyticsTime.MonthlyAnalytics,
                    child: Text('Monthly')),
                const PopupMenuItem<AnalyticsTime>(
                    value: AnalyticsTime.YearlyAnalytics,
                    child: Text('Yearly')),
              ],
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: queryPageName,
              ),
              Tab(
                text: 'History',
              )
            ],
          ),
        ),
        body: MyAnalyticsPage(),
        floatingActionButton: BlocBuilder<AnalyticsBloc, AnalyticsState>(
            builder: (context, state) {
          if (state is AnalyticsLoaded) {
            return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                onPressed: () => BlocProvider.of<AnalyticsOnlineBloc>(context)
                    .add(CreateOnlineAnalysisTapped(
                        appUsageInfos: state.appUsages,
                       // username: offTimeUsername,
                       // tokenKey: tokenKey
                )),
                child: Icon(Icons.add),
              ),
              FloatingActionButton(
                  child: Icon(Icons.add_chart),
                  onPressed: () => BlocProvider.of<AnalyticsOnlineBloc>(context)
                      .add(ReadOnlineAnalysisTapped())),
              FloatingActionButton(
                onPressed: () => BlocProvider.of<AnalyticsOnlineBloc>(context)
                    .add(UpdateOnlineAnalysisTappped(state.appUsages)),
                child: Icon(Icons.refresh),
              ),
              FloatingActionButton(
                onPressed: () => BlocProvider.of<AnalyticsOnlineBloc>(context)
                    .add(DeleteOnlineAnalysisTapped()),
                child: Icon(Icons.delete_forever),
              ),
            ]);
          }
        }),
      ),
    );
  }
}

class MyAnalyticsPage extends StatefulWidget {
  const MyAnalyticsPage({
    Key key,
  }) : super(key: key);

  @override
  _MyAnalyticsPageState createState() => _MyAnalyticsPageState();
}

class _MyAnalyticsPageState extends State<MyAnalyticsPage> {
  String appName;
  String appPackageName;
  String dateOfUse;
  int timeDuration;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AnalyticsBloc>(context)
        .add(AnalyticsEvent.AnalyticsDailyRequested);
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: [
      BlocBuilder<AnalyticsBloc, AnalyticsState>(builder: (context, state) {
        if (state is AnalyticsLoadingError) {
          return Text('Analytics load failed');
        }
        if (state is AnalyticsLoading || state is AnalyticsInitial) {
          return CircularProgressIndicator();
        }
        if (state is AnalyticsLoaded) {
          return ListView.builder(
              itemCount: state.appUsages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.appUsages[index].appName,
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    state.appUsages[index].usage.inMinutes.toString() + ' mins',
                    style: TextStyle(fontSize: 21),
                  ),
                );
              });
        }
      }),
      BlocBuilder<AnalyticsOnlineBloc, AnalyticsOnlineState>(
          builder: (context, state) {
        if (state is GetOnlineAnalysisLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  state.analyticsModels[index].appName,
                ),
                trailing:
                    Text(state.analyticsModels[index].timeDuration.toString()),
              );
            },
            itemCount: state.analyticsModels.length,
          );
        } else {
          return Text("No data to display");
        }
      }),
    ]);
  }
}

/*
          FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                  context: context, builder: (context) => CrudButtons()),
              child: Icon(Icons.menu),
          ),

                 */

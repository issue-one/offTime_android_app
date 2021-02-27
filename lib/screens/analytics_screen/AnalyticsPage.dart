import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/Bussiness%20Logic/Analytics%20Online/analytics_online_bloc.dart';
import 'package:offTime/Bussiness%20Logic/Analytics/analytics_bloc.dart';
import 'package:offTime/models/newAppUsage.dart';
import 'package:offTime/screens/analytics_screen/order_cruds_page.dart';

class AnalyticsPage extends StatelessWidget {
  Widget buildBottomSheet(BuildContext buildContext) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Daily',
              ),
              Tab(
                text: 'Weekly',
              ),
              Tab(
                text: 'Yearly',
              ),
              Tab(
                text: 'History',
              )
            ],
          ),
        ),
        body: MyAnalyticsPage(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context, builder: (context) => CrudButtons()),
          child: Icon(Icons.menu),
        ),
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
      Text('Tab2'),
      Text('Tab3'),
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

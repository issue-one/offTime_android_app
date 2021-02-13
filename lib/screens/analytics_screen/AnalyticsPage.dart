import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offTime/Bussiness%20Logic/Analytics/analytics_bloc.dart';
import 'package:offTime/Data/Data%20Providers/analytics_data.dart';
import 'package:offTime/Data/Repository/analytics_repository.dart';

class AnalyticsPage extends StatelessWidget {
  final AnalyticsRepository analyticsRepository = AnalyticsRepository(
      AnalyticsDataProvider());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AnalyticsBloc(analyticsRepository),
      child: Scaffold(
        body: myAnalyticsPage(),
      ),
    );
  }
}

class myAnalyticsPage extends StatefulWidget {
  const myAnalyticsPage({
    Key key,
  }) : super(key: key);

  @override
  _myAnalyticsPageState createState() => _myAnalyticsPageState();
}

class _myAnalyticsPageState extends State<myAnalyticsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AnalyticsBloc>(context).add(
        AnalyticsEvent.AnalyticsDailyRequested);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            if (state is AnalyticsLoadingError) {
              return Text('Analytics load failed');
            }
            if (state is AnalyticsLoading || state is AnalyticsInitial) {
              return CircularProgressIndicator();
            }
            if (state is AnalyticsLoaded) {
              return ListView.builder(itemCount: state.appUsages.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(state.appUsages[index].appName),
                      trailing: Text(
                          state.appUsages[index].usage.inHours.toString()),);
                  });
            }
          }),
    );
  }
}



import 'package:app_usage/app_usage.dart';
import 'package:offTime/data_provider/analytics_to_server_data_provider.dart';
import 'package:offTime/data_provider/data_provider.dart';
import 'package:offTime/models/models.dart';
import 'dart:core';


class AnalyticsToServerRepository{
  final onlineAnalyticsProvider _analyticsProvider;

  AnalyticsToServerRepository(this._analyticsProvider);

  //NewAppUsage appUsageInfo
  Future<void> createOnlineAnalysis() async{
    //return await _analyticsProvider.createOnlineAnalytics(appUsageInfo);
    return await _analyticsProvider.createOnlineAnaly();

    /*
    appUsageInfo.forEach((element) async{
      //await Duration(milliseconds: 500);
      await _analyticsProvider.createOnlineAnalytics(element);

    });

     */


  }
  Future<List<AnalyticsModel>> getOnlineAnalytics() async{
    return await _analyticsProvider.getOnlineAnalytics();

  }

  Future<void> deleteOnlineAnalytics() async{
    return await _analyticsProvider.deleteOnlineAppUsage();

  }

}
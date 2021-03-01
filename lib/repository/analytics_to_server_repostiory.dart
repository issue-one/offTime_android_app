import 'dart:core';

import 'package:app_usage/app_usage.dart';
import 'package:offTime/data_provider/analytics_to_server_data_provider.dart';
import 'package:offTime/models/analytics_model.dart';

class AnalyticsToServerRepository {
  final onlineAnalyticsProvider _analyticsProvider;

  AnalyticsToServerRepository(this._analyticsProvider);

  //NewAppUsage appUsageInfo
  Future<void> createOnlineAnalysis(List<AppUsageInfo> newAppUsages) async {
    //return await _analyticsProvider.createOnlineAnalytics(newAppUsage);
    //return await _analyticsProvider.createOnlineAnaly();

    newAppUsages.forEach((element) async {
      //await Duration(milliseconds: 500);
      await _analyticsProvider.createOnlineAnalytics(element);
    });
  }

  Future<List<AnalyticsModel>> getOnlineAnalytics() async {
    return await _analyticsProvider.getOnlineAnalytics();
  }

  Future updateOnlineAnalytics(List<AppUsageInfo> appUsageInfos) async {
    //return await _analyticsProvider.updateOnlineAppusage(appUsageInfos);

    appUsageInfos.forEach((element) async {
      await _analyticsProvider.updateOnlineAppusage(element);
    });
  }

  Future<void> deleteOnlineAnalytics() async {
    return await _analyticsProvider.deleteOnlineAppUsage();
  }
}

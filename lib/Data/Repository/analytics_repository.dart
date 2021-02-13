

import 'package:app_usage/app_usage.dart';
import 'package:offTime/Data/Data%20Providers/analytics_data.dart';

class AnalyticsRepository{
  final AnalyticsDataProvider _analyticsDataProvider;

  AnalyticsRepository(this._analyticsDataProvider);

  Future<List<AppUsageInfo>> getDailyAppUsage() async{
    return await _analyticsDataProvider.getUsageStats(Duration(days: 1));
  }

  Future<List<AppUsageInfo>> getWeeklyAppUsage() async{
    return await _analyticsDataProvider.getUsageStats(Duration(days: 7));

  }
  Future<List<AppUsageInfo>> getYearlyAppUsage() async{
    return await _analyticsDataProvider.getUsageStats(Duration(days: 365));
  }

}
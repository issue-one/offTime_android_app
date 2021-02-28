import 'package:app_usage/app_usage.dart';

class AnalyticsDataProvider{


  List<AppUsageInfo> _infos = [];

  Future<List<AppUsageInfo>> getUsageStats(Duration duration) async {
    try {
      DateTime endDate = new DateTime.now();
      DateTime startDate = endDate.subtract(duration);
      List<AppUsageInfo> infoList = await AppUsage.getAppUsage(startDate, endDate);


      for (var info in infoList) {
        print(info.toString());
      }
      return infoList;
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

}
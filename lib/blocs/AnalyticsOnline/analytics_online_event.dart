part of 'analytics_online_bloc.dart';

@immutable
abstract class AnalyticsOnlineEvent {}

class CreateOnlineAnalysisTapped extends AnalyticsOnlineEvent{
  final List<AppUsageInfo> appUsageInfos;
  //final String username;
  //final String tokenKey;

  //CreateOnlineAnalysisTapped({this.appUsageInfos, this.username, this.tokenKey});
  CreateOnlineAnalysisTapped({this.appUsageInfos});
}

class ReadOnlineAnalysisTapped extends AnalyticsOnlineEvent{
  final String username;
  final String tokenKey;

  ReadOnlineAnalysisTapped({this.username, this.tokenKey});
  /*
  final AppUsageInfo appUsageInfo;

  ReadOnlineAnalysisTapped(this.appUsageInfo);

   */
}

class UpdateOnlineAnalysisTappped extends AnalyticsOnlineEvent{
  final List<AppUsageInfo> appUsageInfo;

  UpdateOnlineAnalysisTappped(this.appUsageInfo);
  //final String username;
  //final String tokenKey;

  //UpdateOnlineAnalysisTappped({this.appUsageInfo, this.username, this.tokenKey});

}

class DeleteOnlineAnalysisTapped extends AnalyticsOnlineEvent{
  //final String username;
  //final String tokenKey;

  //DeleteOnlineAnalysisTapped({this.username, this.tokenKey});

}
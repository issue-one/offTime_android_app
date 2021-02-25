part of 'analytics_online_bloc.dart';

@immutable
abstract class AnalyticsOnlineEvent {}

class CreateOnlineAnalysisTapped extends AnalyticsOnlineEvent{
  final NewAppUsage appUsageInfo;

  CreateOnlineAnalysisTapped(this.appUsageInfo);
}

class ReadOnlineAnalysisTapped extends AnalyticsOnlineEvent{
  /*
  final AppUsageInfo appUsageInfo;

  ReadOnlineAnalysisTapped(this.appUsageInfo);

   */
}

class UpdateOnlineAnalysisTappped extends AnalyticsOnlineEvent{
  final AppUsageInfo appUsageInfo;

  UpdateOnlineAnalysisTappped(this.appUsageInfo);

}

class DeleteOnlineAnalysisTapped extends AnalyticsOnlineEvent{

}
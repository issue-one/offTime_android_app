part of 'analytics_bloc.dart';

@immutable
abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState{}

class AnalyticsLoaded extends AnalyticsState{
  final List<AppUsageInfo> appUsages;

  AnalyticsLoaded(this.appUsages);
}

class AnalyticsLoadingError extends AnalyticsState{}

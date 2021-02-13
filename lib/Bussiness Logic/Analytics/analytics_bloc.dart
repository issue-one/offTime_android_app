import 'dart:async';

import 'package:app_usage/app_usage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:offTime/Data/Repository/analytics_repository.dart';

part 'analytics_event.dart';

part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRepository analyticsRepository;

  AnalyticsBloc(this.analyticsRepository) : super(AnalyticsInitial());

  @override
  Stream<AnalyticsState> mapEventToState(
    AnalyticsEvent event,
  ) async* {
    if (event == AnalyticsEvent.AnalyticsDailyRequested) {
      yield AnalyticsLoading();

      try {
        final dailyAnalytics = await analyticsRepository.getDailyAppUsage();
        yield AnalyticsLoaded(dailyAnalytics);
      } catch (_) {
        yield AnalyticsLoadingError();
      }
    }

    if(event == AnalyticsEvent.AnalyticsWeeklyRequested){
      yield AnalyticsLoading();

      try{
        final weeklyAnalytics= await analyticsRepository.getWeeklyAppUsage();
        yield AnalyticsLoaded(weeklyAnalytics);
      }catch(_){
        yield AnalyticsLoadingError();
      }
    }

    if(event == AnalyticsEvent.AnalyticsYearlyRequested){
      yield AnalyticsLoading();

      try{
        final yearlyAnalytics = await analyticsRepository.getYearlyAppUsage();
        yield AnalyticsLoaded(yearlyAnalytics);
      }catch(_){
        yield AnalyticsLoadingError();
      }
    }
  }
}

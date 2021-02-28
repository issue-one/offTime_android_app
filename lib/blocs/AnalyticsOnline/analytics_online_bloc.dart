import 'dart:async';

import 'package:app_usage/app_usage.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:offTime/models/models.dart';
import 'package:offTime/repository/analytics_to_server_repostiory.dart';

part 'analytics_online_event.dart';
part 'analytics_online_state.dart';

class AnalyticsOnlineBloc extends Bloc<AnalyticsOnlineEvent, AnalyticsOnlineState> {
  final AnalyticsToServerRepository analyticsToServerRepository;
  AnalyticsOnlineBloc(this.analyticsToServerRepository) : super(AnalyticsOnlineInitial());

  @override
  Stream<AnalyticsOnlineState> mapEventToState(
    AnalyticsOnlineEvent event,
  ) async* {
    if(event is CreateOnlineAnalysisTapped){
      yield CreateOnlineAnalysisLoading();
      try{
       // final onlineAnalysis = await analyticsToServerRepository.createOnlineAnalysis(event.appUsageInfo);
        final onlineAnalysis = await analyticsToServerRepository.createOnlineAnalysis();
        yield CreateOnlineAnalysisLoaded();
      } catch(_){
        yield CreateOnlineAnalysisFailed();
      }


    }

    if(event is ReadOnlineAnalysisTapped){
      yield GetOnlineAnalysisLoading();
      try{
        final onlineAnalysis = await analyticsToServerRepository.getOnlineAnalytics();
        yield GetOnlineAnalysisLoaded(onlineAnalysis);
      }catch(e){
        print(e);
        yield GetOnlineAnalysisFailed();
      }
    }

    if(event is DeleteOnlineAnalysisTapped){
      yield DeleteOnlineAnalysisLoading();
      try{
        final onlineAnalysis = await analyticsToServerRepository.deleteOnlineAnalytics();
        yield DeleteOnlineAnalysisLoaded();
      }catch(_){
        yield DeleteOnlineAnalysisFailed();
      }
    }
  }
}

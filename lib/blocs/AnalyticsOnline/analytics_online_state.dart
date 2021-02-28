part of 'analytics_online_bloc.dart';

@immutable
abstract class AnalyticsOnlineState {}

class AnalyticsOnlineInitial extends AnalyticsOnlineState {}

class CreateOnlineAnalysisLoading extends AnalyticsOnlineState{}

class CreateOnlineAnalysisLoaded extends AnalyticsOnlineState{
  /*
  final AnalyticsModel analyticsModel;

  CreateOnlineAnalysisLoaded(this.analyticsModel);

   */
}

class CreateOnlineAnalysisFailed extends AnalyticsOnlineState{

}

class GetOnlineAnalysisLoading extends AnalyticsOnlineState{}

class GetOnlineAnalysisLoaded extends AnalyticsOnlineState{
  final List<AnalyticsModel> analyticsModels;

  GetOnlineAnalysisLoaded(this.analyticsModels);
}

class GetOnlineAnalysisFailed extends AnalyticsOnlineState{}

class UpdateOnlineAnalysisLoading extends AnalyticsOnlineState{}

class UpdateOnlineAnalysisLoaded extends AnalyticsOnlineState{
  final List<AnalyticsModel> analyticsModel;

  UpdateOnlineAnalysisLoaded(this.analyticsModel);
}

class UpdateOnlineAnalysisFailed extends AnalyticsOnlineState{}

class DeleteOnlineAnalysisLoading extends AnalyticsOnlineState{}

class DeleteOnlineAnalysisLoaded extends AnalyticsOnlineState{}

class DeleteOnlineAnalysisFailed extends AnalyticsOnlineState{}
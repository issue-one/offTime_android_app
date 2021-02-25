class AnalyticsModel {
  final String appName;
  final String appPackageName;
  final int timeDuration;

  AnalyticsModel({this.appName, this.appPackageName, this.timeDuration});


  factory AnalyticsModel.fromJson(Map<String, dynamic> json){
    return AnalyticsModel(appName: json['appName'],
        appPackageName: json['appPackageName'],
        timeDuration: json['timeDuration']);
  }
}
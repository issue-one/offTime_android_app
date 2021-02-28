import 'dart:convert';

import 'package:app_usage/app_usage.dart';
import 'package:http/http.dart' as http;
import 'package:offTime/models/analytics_model.dart';

class onlineAnalyticsProvider {
  final _baseUrl = 'http://192.168.1.4:8080';
  final http.Client httpClient;
  final String offTimeUsername = 'tseahay';

  onlineAnalyticsProvider(this.httpClient);

  Future<AnalyticsModel> createOnlineAnaly() async{
    final response = await httpClient.post(
      Uri.http('192.168.1.10:8080', '/users/${offTimeUsername}/usageHistory'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },

      body: jsonEncode(<String, dynamic>{
        "appName": "Movex",
        "appPackageName": "com.snap.snapchat",
        "dateOfUse": "2008-02-16",
        "timeDuration": 50
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return AnalyticsModel.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 400){
      print('response status code==${response.statusCode}');
      throw Exception('Failed to create AppUsageInfo');
    } else if(response.statusCode ==415) {
      print(jsonDecode(response.body));
      throw Exception('Failed to create AppUsage Info');
    }
  }

  Future<AnalyticsModel> createOnlineAnalytics(
      AppUsageInfo appUsageInfo) async {
    final response = await httpClient.post(
      Uri.http('192.168.1.4:8080', '/users/${offTimeUsername}/apUsageHistory'),

      headers: <String, String>{
        'Content-Type': 'application/json',
      },


      body: jsonEncode(<String, dynamic>{
        "appName": "${appUsageInfo.appName}",
        "appPackageName": "${appUsageInfo.packageName}",
        "dateOfUse": "2021-02-16",
        "timeDuration": appUsageInfo.usage.inMinutes
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      return AnalyticsModel.fromJson(jsonDecode(response.body));
    } else {
      print('response status code==${response.statusCode}');
      print('response message == ${response.body}');
      //throw Exception('Failed to create AppUsageInfo');
    }
  }

  Future<List<AnalyticsModel>> getOnlineAnalytics() async {
    final response =
        await httpClient.get('$_baseUrl/users/$offTimeUsername/usageHistory');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final rawResponse = jsonDecode(response.body);
      final items = rawResponse['items'] as List;
      //final oldAnalytics = jsonDecode(response.body) as List;
      return items
          .map((analyticsModel) => AnalyticsModel.fromJson(analyticsModel)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<void> deleteOnlineAppUsage() async{
    final http.Response response = await httpClient.delete(
      '$_baseUrl/users/$offTimeUsername/usageHistory',


    );
    if(response.statusCode!=200 ){
      throw Exception('Failed to delete analtics');
    }
  }

  Future updateOnlineAppusage(AppUsageInfo appUsageInfo) async{
    final response = await httpClient.post(
      Uri.http('192.168.1.4:8080', '${offTimeUsername}/usageHistory'),
      /*
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

       */
      body: jsonEncode(<String, dynamic>{
        "appName": "${appUsageInfo.appName}",
        "appPackageName": "${appUsageInfo.packageName}",
        "dateOfUse": "2021-02-16",
        "timeDuration": appUsageInfo.usage.inMinutes
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      return AnalyticsModel.fromJson(jsonDecode(response.body));
    } else {
      print('response status code==${response.statusCode}');
      //throw Exception('Failed to create AppUsageInfo');
    }
  }
}

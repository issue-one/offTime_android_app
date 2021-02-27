import 'dart:convert';

import 'package:app_usage/app_usage.dart';
import 'package:http/http.dart' as http;
import 'package:offTime/models/analytics_model.dart';
import 'package:offTime/models/newAppUsage.dart';

class onlineAnalyticsProvider {
  final _baseUrl = 'http://192.168.137.1:8080';
  final http.Client httpClient;
  final String offTimeUsername = 'tseahay';

  onlineAnalyticsProvider(this.httpClient);

  Future<AnalyticsModel> createOnlineAnaly() async{
    final response = await httpClient.post(
      Uri.http('192.168.137.1:8080', '${offTimeUsername}/usageHistory'),

      body: jsonEncode(<String, dynamic>{
        "appName": "Outo mechanic",
        "appPackageName": "com.ambaethiopia.carcare",
        "dateOfUse": "2021-02-16",
        "timeDuration": 50
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

  Future<AnalyticsModel> createOnlineAnalytics(
      NewAppUsage appUsageInfo) async {
    final response = await httpClient.post(
      Uri.http('192.168.137.1:8080', '${offTimeUsername}/usageHistory'),
      /*
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

       */
      body: jsonEncode(<String, dynamic>{
        "appName": "${appUsageInfo.appName}",
        "appPackageName": "${appUsageInfo.appPackageName}",
        "dateOfUse": "2021-02-16",
        "timeDuration": appUsageInfo.timeDuration
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
      Uri.http('192.168.137.1:8080', '${offTimeUsername}/usageHistory'),
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

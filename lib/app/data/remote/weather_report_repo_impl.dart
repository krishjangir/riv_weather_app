import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/app_config.dart';
import '../../domain/repository/weather_report_repo.dart';
import '../model/weather_model.dart';

class WeatherReportRepoImpl implements WeatherReportRepo {
  @override
  Future<WeatherModel> getWeather(String query) async {
    final url = Uri.parse(
        '${AppConfig.baseUrl}/weather?q=$query&appid=${AppConfig.apiKey}');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to getWeather');
    }
  }
}

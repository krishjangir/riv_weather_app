
import '../../data/model/weather_model.dart';

abstract class WeatherReportRepo {
  Future<WeatherModel> getWeather(String query);
}

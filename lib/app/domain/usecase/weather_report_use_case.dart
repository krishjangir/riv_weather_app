
import '../../data/model/weather_model.dart';

abstract class WeatherReportUseCase {
  Future<WeatherModel> getWeather(String query);
}
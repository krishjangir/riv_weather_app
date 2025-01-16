

import 'package:riv_weather_app/app/domain/usecase/weather_report_use_case.dart';

import '../../data/model/weather_model.dart';
import '../repository/weather_report_repo.dart';

class WeatherReportUseCaseImpl implements WeatherReportUseCase {
  final WeatherReportRepo repository;

  WeatherReportUseCaseImpl(this.repository);

  @override
  Future<WeatherModel> getWeather(String query) {
    return repository.getWeather(query);
  }
}

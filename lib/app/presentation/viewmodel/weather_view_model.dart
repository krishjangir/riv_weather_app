import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/weather_model.dart';
import '../../data/remote/weather_report_repo_impl.dart';
import '../../domain/usecase/weather_report_use_case.dart';
import '../../domain/usecase/weather_report_use_case_impl.dart';

class WeatherViewModel extends AsyncNotifier<WeatherModel> {
  final WeatherReportUseCase weatherReportUseCase;

  WeatherViewModel(this.weatherReportUseCase);

  Future<void> fetchWeatherByQuery(String query) async {
    state = const AsyncValue.loading(); // Update state to loading
    try {
      final weather = await weatherReportUseCase.getWeather(query);
      state = AsyncValue.data(weather); // Wrap result in AsyncValue.data
    } catch (e, s) {
      state = AsyncValue.error(e, s); // Handle errors
    }
  }

  @override
  Future<WeatherModel> build() async {
    try {
      return await weatherReportUseCase.getWeather("Bengaluru");
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      rethrow;
    }
  }
}

final weatherViewModelProvider =
    AsyncNotifierProvider<WeatherViewModel, WeatherModel>(
  () => WeatherViewModel(WeatherReportUseCaseImpl(WeatherReportRepoImpl())),
);

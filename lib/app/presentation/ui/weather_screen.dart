import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/debouncer.dart';
import '../viewmodel/weather_view_model.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deBouncer = DeBouncer(milliseconds: 500);
    final weatherState = ref.watch(weatherViewModelProvider);
    final viewModel = ref.read(weatherViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xdc045cbb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    fillColor: const Color(0xffF3F3F3),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onChanged: (query) {
                    deBouncer.run(() {
                      viewModel.fetchWeatherByQuery(query);
                    });
                  },
                ),
                const SizedBox(height: 32.0),
                weatherState.when(
                  data: (weather) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'City: ${weather.cityName}, Temperature: ${weather.temperature}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, _) =>
                      Text('Error fetching user details: $error'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

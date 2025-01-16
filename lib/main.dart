import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/weather_app.dart';

void main() {
  /**
   * @function runZonedGuarded() is used to prevent uncaught exceptions from crashing the entire application
   */
  runZonedGuarded(() async {
    /**
     * Ensure that Flutter bindings are initialized before running the app.
     */
    WidgetsFlutterBinding.ensureInitialized();
    /**
     * For screen support portrait / landscape
     */
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    /**
     * Adding ProviderScope enables Riverpod for the entire project
     */
    runApp(const ProviderScope(child: WeatherApp()));
  }, (error, stack) {
    log('An error occurred: - $error');
  }, zoneSpecification: const ZoneSpecification());
}

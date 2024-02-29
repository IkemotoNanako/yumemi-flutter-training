import 'dart:convert';

import 'package:flutter_training/weather/domain/weather_class.dart';
import 'package:flutter_training/weather/domain/weather_request_class.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_repository.g.dart';

@riverpod
Weather weatherRepository(WeatherRepositoryRef ref) {
  final yumemiWeather = YumemiWeather();
  try {
    final request = WeatherRequest.sample();
    final requestString = jsonEncode(request.toJson());
    final weatherString = yumemiWeather.fetchWeather(requestString);
    final weatherJson = json.decode(weatherString) as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  } on YumemiWeatherError catch (_) {
    rethrow;
  }
}

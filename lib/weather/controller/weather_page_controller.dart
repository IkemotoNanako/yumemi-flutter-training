import 'package:flutter_training/weather/domain/weather_class.dart';
import 'package:flutter_training/weather/repository/weather_repository.dart';
import 'package:flutter_training/weather/state/weather_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_page_controller.g.dart';

@riverpod
class WeatherPageController extends _$WeatherPageController {
  @override
  WeatherState build() {
    return WeatherState(weather: Weather());
  }

  void fetchWeather() {
    final weather = ref.read(weatherRepositoryProvider);

    state = state.copyWith(weather: weather);
  }
}

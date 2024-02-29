import 'package:flutter_training/weather/domain/weather_class.dart';
import 'package:flutter_training/weather/repository/weather_repository.dart';
import 'package:flutter_training/weather/state/weather_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_page_controller.g.dart';

@riverpod
class WeatherPageController extends _$WeatherPageController {
  @override
  Future<WeatherState> build() async {
    return WeatherState(weather: Weather());
  }

  Future<void> fetchWeather() async {
    final weatherRepository = ref.watch(weatherRepositoryProvider);
    state = await AsyncValue.guard(() async {
      final weather = weatherRepository.fetchWeather();
      return WeatherState(weather: weather);
    });
  }
}

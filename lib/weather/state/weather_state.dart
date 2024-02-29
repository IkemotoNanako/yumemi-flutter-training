import 'package:flutter_training/weather/domain/weather_class.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_state.freezed.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState({
    required Weather weather,
  }) = _WeatherState;
}

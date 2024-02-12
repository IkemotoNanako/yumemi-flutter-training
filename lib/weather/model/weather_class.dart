import 'package:flutter_training/weather/enum/weather_condition_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_class.g.dart';

@JsonSerializable()
class Weather {
  Weather({
    required this.weatherCondition,
    required this.minTemperature,
    required this.maxTemperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @JsonKey(name: 'weather_condition')
  final WeatherCondition? weatherCondition;

  @JsonKey(name: 'min_temperature')
  final int? minTemperature;

  @JsonKey(name: 'max_temperature')
  final int? maxTemperature;
}

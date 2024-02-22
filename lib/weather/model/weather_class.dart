import 'package:flutter_training/weather/enum/weather_condition_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_class.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Weather {
  Weather({
    this.weatherCondition,
    this.minTemperature,
    this.maxTemperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  final WeatherCondition? weatherCondition;

  final int? minTemperature;

  final int? maxTemperature;
}

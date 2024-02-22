// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      weatherCondition: $enumDecodeNullable(
        _$WeatherConditionEnumMap,
        json['weather_condition'],
      ),
      minTemperature: json['min_temperature'] as int?,
      maxTemperature: json['max_temperature'] as int?,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'weather_condition': _$WeatherConditionEnumMap[instance.weatherCondition],
      'min_temperature': instance.minTemperature,
      'max_temperature': instance.maxTemperature,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
};

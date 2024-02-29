// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherRequest _$WeatherRequestFromJson(Map<String, dynamic> json) =>
    WeatherRequest(
      area: json['area'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$WeatherRequestToJson(WeatherRequest instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date,
    };

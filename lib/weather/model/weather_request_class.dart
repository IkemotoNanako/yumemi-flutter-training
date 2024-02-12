import 'package:json_annotation/json_annotation.dart';

part 'weather_request_class.g.dart';

@JsonSerializable()
class WeatherRequest {
  WeatherRequest({
    required this.area,
    required this.date,
  });

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRequestToJson(this);

  final String area;

  final String date;
}

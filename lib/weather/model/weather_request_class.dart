import 'package:json_annotation/json_annotation.dart';

part 'weather_request_class.g.dart';

@JsonSerializable()
class WeatherRequest {
  WeatherRequest({
    required this.area,
    required this.date,
  });

  factory WeatherRequest.sample() {
    return WeatherRequest(
      area: 'tokyo',
      date: '2020-04-01T12:00:00+09:00',
    );
  }

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherRequestToJson(this);

  final String area;

  final String date;
}

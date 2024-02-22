import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class Weather {
  Weather({
    required this.weatherCondition,
    required this.minTemperature,
    required this.maxTemperature,
  });

  Weather.fromJson(Map<String, dynamic> json)
      : weatherCondition = WeatherCondition.values
            .byNameOrNull(json['weather_condition'].toString()),
        minTemperature = json['min_temperature'] as int,
        maxTemperature = json['max_temperature'] as int;

  WeatherCondition? weatherCondition;
  int? minTemperature;
  int? maxTemperature;
}

enum WeatherCondition {
  sunny(label: 'sunny'),
  cloudy(label: 'cloudy'),
  rainy(label: 'rainy'),
  ;

  const WeatherCondition({
    required this.label,
  });

  final String label;

  Widget get icon {
    switch (this) {
      case WeatherCondition.sunny:
        return SvgPicture.asset(
          'assets/sunny.svg',
          semanticsLabel: label,
        );
      case WeatherCondition.cloudy:
        return SvgPicture.asset(
          'assets/cloudy.svg',
          semanticsLabel: label,
        );
      case WeatherCondition.rainy:
        return SvgPicture.asset(
          'assets/rainy.svg',
          semanticsLabel: label,
        );
    }
  }
}

extension EnumByName<T extends Enum> on Iterable<T> {
  T? byNameOrNull(String? name) {
    for (final value in this) {
      if (value.name == name) {
        return value;
      }
    }
    return null;
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final YumemiWeather _yumemiWeather = YumemiWeather();
  Weather _weather = Weather(
    weatherCondition: null,
    minTemperature: null,
    maxTemperature: null,
  );

  Future<void> _fetchWeather() async {
    try {
      const jsonString = '''
{
    "area": "tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}''';
      final weatherString = _yumemiWeather.fetchWeather(jsonString);
      final weatherMap = json.decode(weatherString) as Map<String, dynamic>;

      setState(() {
        _weather = Weather.fromJson(weatherMap);
      });
    } on YumemiWeatherError catch (e) {
      await showDialog<void>(
        context: context,
        builder: (_) {
          return ErrorAlertDialog(
            message: e.message,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: SizedBox.expand(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child:
                        _weather.weatherCondition?.icon ?? const Placeholder(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              '${_weather.minTemperature ?? '**'} ℃',
                              style: textTheme.labelLarge?.copyWith(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              '${_weather.maxTemperature ?? '**'} ℃',
                              style: textTheme.labelLarge?.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                'close',
                                style: textTheme.labelLarge?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: TextButton(
                              onPressed: _fetchWeather,
                              child: Text(
                                'reload',
                                style: textTheme.labelLarge?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('エラー'),
      content: Text(message),
      actions: <Widget>[
        GestureDetector(
          child: const Text('OK'),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
  }
}

extension on YumemiWeatherError {
  String get message {
    switch (this) {
      case YumemiWeatherError.invalidParameter:
        return '無効なパラメータです';
      case YumemiWeatherError.unknown:
        return '不明なエラーです';
    }
  }
}

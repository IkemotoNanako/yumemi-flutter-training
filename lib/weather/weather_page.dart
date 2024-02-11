import 'dart:convert';

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
            .byName(json['weather_condition'].toString()),
        minTemperature = json['min_temperature'] as int,
        maxTemperature = json['max_temperature'] as int;

  WeatherCondition weatherCondition;
  int? minTemperature;
  int? maxTemperature;
}

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
  other,
}

extension WeatherConditionExtension on WeatherCondition {
  String get name {
    switch (this) {
      case WeatherCondition.sunny:
        return 'sunny';
      case WeatherCondition.cloudy:
        return 'cloudy';
      case WeatherCondition.rainy:
        return 'rainy';
      case WeatherCondition.other:
        return '';
    }
  }

  Widget get icon {
    switch (this) {
      case WeatherCondition.sunny:
        return SvgPicture.asset(
          'assets/sunny.svg',
          semanticsLabel: 'sunny',
        );
      case WeatherCondition.cloudy:
        return SvgPicture.asset(
          'assets/cloudy.svg',
          semanticsLabel: 'cloudy',
        );
      case WeatherCondition.rainy:
        return SvgPicture.asset(
          'assets/rainy.svg',
          semanticsLabel: 'rainy',
        );
      case WeatherCondition.other:
        return const Placeholder();
    }
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
    weatherCondition: WeatherCondition.other,
    minTemperature: null,
    maxTemperature: null,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    Future<void> fetchWeather() async {
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
      } on YumemiWeatherError catch (_) {
        await showDialog<void>(
          context: context,
          builder: (_) {
            return const ErrorAlertDialog();
          },
        );
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 2,
                  height: width / 2,
                  child: _weather.weatherCondition.icon,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 4,
                        child: Center(
                          child: Text(
                            '${_weather.minTemperature ?? '**'} ℃',
                            style: textTheme.labelLarge!.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 4,
                        child: Center(
                          child: Text(
                            '${_weather.maxTemperature ?? '**'} ℃',
                            style: textTheme.labelLarge!.copyWith(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 4,
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'close',
                              style: textTheme.labelLarge!.copyWith(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width / 4,
                        child: Center(
                          child: TextButton(
                            onPressed: fetchWeather,
                            child: Text(
                              'reload',
                              style: textTheme.labelLarge!.copyWith(
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
    );
  }
}

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('仮のテキスト'),
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
}

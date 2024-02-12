import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/weather/enum/weather_condition_enum.dart';
import 'package:flutter_training/weather/model/weather_class.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

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
        final weatherJson = json.decode(weatherString) as Map<String, dynamic>;

        setState(() {
          _weather = Weather.fromJson(weatherJson);
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
                  child: _weather.weatherCondition == null
                      ? const Placeholder()
                      : _weather.weatherCondition!.icon,
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

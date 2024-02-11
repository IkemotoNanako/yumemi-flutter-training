import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

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

WeatherCondition convertStringToWeatherCondition(String conditionString) {
  switch (conditionString) {
    case 'sunny':
      return WeatherCondition.sunny;
    case 'cloudy':
      return WeatherCondition.cloudy;
    case 'rainy':
      return WeatherCondition.rainy;
    default:
      return WeatherCondition.other;
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final YumemiWeather _yumemiWeather = YumemiWeather();
  WeatherCondition _weatherCondition = WeatherCondition.other;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

    void fetchWeather() {
      final weather = _yumemiWeather.fetchSimpleWeather();
      setState(() {
        _weatherCondition = convertStringToWeatherCondition(weather);
      });
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
                  child: _weatherCondition.icon,
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
                            '** ℃',
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
                            '** ℃',
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

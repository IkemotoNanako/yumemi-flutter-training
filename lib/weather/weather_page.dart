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
    final textTheme = Theme.of(context).textTheme;

    void fetchWeather() {
      final weather = _yumemiWeather.fetchSimpleWeather();
      setState(() {
        _weatherCondition = WeatherCondition.values.byName(weather);
      });
    }

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
                    child: _weatherCondition.icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              '** ℃',
                              style: textTheme.labelLarge?.copyWith(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              '** ℃',
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
                              onPressed: () {},
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
                              onPressed: fetchWeather,
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

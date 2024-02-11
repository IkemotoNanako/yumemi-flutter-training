import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
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
      return WeatherCondition.sunny;
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    final yumemiWeather = YumemiWeather();
    var weatherCondition = WeatherCondition.sunny;
    void fetchWeather() {
      setState(() {
        final weather = yumemiWeather.fetchSimpleWeather();
        weatherCondition = convertStringToWeatherCondition(weather);
        print(weatherCondition);
      });
    }

    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;

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
                  child: const Placeholder(),
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
                            onPressed: () {},
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

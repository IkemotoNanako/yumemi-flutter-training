import 'package:flutter/material.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                            onPressed: () {
                              final yumemiWeather = YumemiWeather();
                              final weatherCondition =
                                  yumemiWeather.fetchSimpleWeather();
                              print('Weather Condition: $weatherCondition');
                            },
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

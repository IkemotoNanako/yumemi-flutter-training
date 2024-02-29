import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/weather/controller/weather_page_controller.dart';
import 'package:flutter_training/weather/domain/weather_condition_enum.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  // final YumemiWeather _yumemiWeather = YumemiWeather();
  // Weather _weather = Weather();

  // Future<void> _fetchWeather() async {
  //   try {
  //     final request = WeatherRequest.sample();
  //     final requestString = jsonEncode(request.toJson());
  //     final weatherString = _yumemiWeather.fetchWeather(requestString);
  //     final weatherJson = json.decode(weatherString) as Map<String, dynamic>;

  //     setState(() {
  //       _weather = Weather.fromJson(weatherJson);
  //     });
  //   } on YumemiWeatherError catch (e) {
  //     await showDialog<void>(
  //       context: context,
  //       builder: (_) {
  //         return ErrorAlertDialog(
  //           message: e.message,
  //         );
  //       },
  //     );
  //   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final controller = ref.watch(weatherPageControllerProvider.notifier);
    final state = ref.watch(weatherPageControllerProvider);

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
                    child: state.weather.weatherCondition?.icon ??
                        const Placeholder(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: Text(
                              '${state.weather.minTemperature ?? '**'} ℃',
                              style: textTheme.labelLarge?.copyWith(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              '${state.weather.maxTemperature ?? '**'} ℃',
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
                              onPressed: controller.fetchWeather,
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

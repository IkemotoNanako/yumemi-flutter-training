import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

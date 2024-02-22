import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather_page.dart';

mixin AfterFirstLayoutMixin<T extends StatefulWidget> on State<T> {
  Future<void> afterFirstLayout();

  @override
  void initState() {
    super.initState();
    Future(() async {
      await WidgetsBinding.instance.endOfFrame.then((_) async {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        if (!mounted) {
          return;
        }
        await afterFirstLayout();
      });
    });
  }
}

class GreenPage extends StatefulWidget {
  const GreenPage({super.key});

  @override
  State<GreenPage> createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> with AfterFirstLayoutMixin {
  @override
  Future<void> afterFirstLayout() async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return const WeatherPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}

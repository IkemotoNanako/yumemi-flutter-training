import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather_page.dart';

mixin afterFirstLayoutMixin<T extends StatefulWidget> on State<T> {
  Future<void> afterFirstLayout() async {}

  @override
  void initState() {
    super.initState();
    Future(() async {
      await WidgetsBinding.instance.endOfFrame.then(
        (_) =>
            Future<void>.delayed(const Duration(milliseconds: 500)).then((_) {
          afterFirstLayout();
        }),
      );
    });
  }
}

class GreenPage extends StatefulWidget {
  const GreenPage({super.key});

  @override
  State<GreenPage> createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> with afterFirstLayoutMixin {
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

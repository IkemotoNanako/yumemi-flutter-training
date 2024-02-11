import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather_page.dart';

class GreenPage extends StatefulWidget {
  const GreenPage({super.key});

  @override
  State<GreenPage> createState() => _GreenPageState();
}

class _GreenPageState extends State<GreenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame
        .then((_) => Future.delayed(Duration(milliseconds: 500)).then((_) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WeatherPage()));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      home: Scaffold(
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
                    const AspectRatio(
                      aspectRatio: 1,
                      child: Placeholder(),
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
                                onPressed: () {},
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
      ),
    );
  }
}

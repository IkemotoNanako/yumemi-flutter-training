import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
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
                        onPressed: () {},
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
      ),
    );
  }
}

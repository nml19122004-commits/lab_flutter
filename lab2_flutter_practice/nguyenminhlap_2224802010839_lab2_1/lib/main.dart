import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LayoutApp()),
    );
  }
}

class LayoutApp extends StatelessWidget {
  const LayoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'I\'m in a Column and Centered. The below is a row.',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.red,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.green,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
              Container(
                width: 80,
                height: 80,
                color: Colors.blue,
                margin: const EdgeInsets.symmetric(horizontal: 5),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(width: 300, height: 200, color: Colors.yellow),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Stacked on Yellow Box',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

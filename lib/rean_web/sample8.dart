import 'package:flutter/material.dart';

class Sample8 extends StatefulWidget {
  const Sample8({super.key});

  @override
  State<Sample8> createState() => _Sample8State();
}

class _Sample8State extends State<Sample8> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateless vs Stateful Widget'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sample7');
              },
              child: const Text('Go to Sample 7 (Stateful Widget)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sample6');
              },
              child: const Text('Go to Sample 6 (Stateless Widget)'),
            ),
          ],
        ),
      ),
    );
  }
}

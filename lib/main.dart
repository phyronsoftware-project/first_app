import 'package:first_app/rean_web/sample4.dart';
import 'package:first_app/rean_web/sample4_1.dart';
import 'package:first_app/rean_web/sample5.dart';
import 'package:first_app/rean_web/sample7.dart';
import 'package:first_app/rean_web/sample8.dart';
import 'package:first_app/rean_web/sample9.dart';
import 'package:flutter/material.dart';
import 'rean_web/test1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Sample9(),
    );
  }
}

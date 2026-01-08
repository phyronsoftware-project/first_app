import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sample41 extends StatefulWidget {
  const Sample41({
    super.key,
    required this.img,
    required this.name,
    required this.desc,
  });
  final img;
  final name;
  final desc;

  @override
  State<Sample41> createState() => _Sample41State();
}

class _Sample41State extends State<Sample41> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: SvgPicture.network(
                widget.img,
                height: 100,
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            Text(
              widget.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Text(
                widget.desc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

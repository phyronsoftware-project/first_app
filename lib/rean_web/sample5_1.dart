import 'package:flutter/material.dart';

class Sample51 extends StatefulWidget {
  const Sample51({
    super.key,
    required this.title,
    required this.img,
    required this.name,
    required this.price,
    required this.desc,
    required this.stock,
  });

  final String title;
  final String img;
  final String name;
  final String price;
  final String desc;
  final String stock;

  @override
  State<Sample51> createState() => _Sample51State();
}

class _Sample51State extends State<Sample51> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(widget.img, height: 200),
            const SizedBox(height: 20),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${widget.price}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Stock Available: ${widget.stock}',
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

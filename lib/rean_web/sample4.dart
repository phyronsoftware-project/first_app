import 'package:first_app/rean_web/sample4_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sample4 extends StatefulWidget {
  const Sample4({super.key});

  @override
  State<Sample4> createState() => _Sample4State();
}

class _Sample4State extends State<Sample4> {
  final List<Map<String, String>> myData = [
    {
      "name": "Apple",
      "des": "https://www.apple.com",
      "img":
          "https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg",
      "desc":
          "Apple is an American technology company known for iPhone, iPad, and Mac.",
    },
    {
      "name": "Google",
      "des": "https://www.google.com",
      "img":
          "https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg",
      "desc":
          "Google specializes in internet-related services and products like Search and Android.",
    },
    {
      "name": "Microsoft",
      "des": "https://www.microsoft.com",
      "img":
          "https://upload.wikimedia.org/wikipedia/commons/4/44/Microsoft_logo.svg",
      "desc":
          "Microsoft develops Windows OS, Office, and cloud services like Azure.",
    },
    {
      "name": "Amazon",
      "des": "https://www.amazon.com",
      "img":
          "https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg",
      "desc": "Amazon is a global e-commerce and cloud computing company.",
    },
    {
      "name": "Tesla",
      "des": "https://www.tesla.com",
      "img":
          "https://upload.wikimedia.org/wikipedia/commons/b/bd/Tesla_Motors.svg",
      "desc": "Tesla designs electric vehicles and clean energy solutions.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample4 Page'),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView.builder(
        itemCount: myData.length,
        itemBuilder: (context, index) {
          final item = myData[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.network(
                  item['img'] ?? 'Empty',
                  height: 30,
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              title: Text(
                item['name'] ?? 'No Name',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(item['des'] ?? 'No Description'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sample41(
                      img: item['img'] ?? '',
                      name: item['name'] ?? '',
                      desc: item['desc'] ?? '',
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

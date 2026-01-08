import 'dart:convert';

import 'package:first_app/rean_web/sample5_1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Sample5 extends StatefulWidget {
  const Sample5({super.key});

  @override
  State<Sample5> createState() => _Sample5State();
}

class _Sample5State extends State<Sample5> {
  var data = [];
  var check = false;
  void fetchData() async {
    var url = Uri.parse('https://dummyjson.com/products/category/smartphones');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body)['products'];
        check = true;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Products'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: check == false
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // ✅ two columns
                  crossAxisSpacing: 12, // space between columns
                  mainAxisSpacing: 12, // space between rows
                  childAspectRatio: 0.72, // card ratio
                ),

                itemBuilder: (context, index) {
                  final item = data[index];

                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Sample51(
                          title: 'Detail Page',
                          img: item['thumbnail'],
                          name: item['title'],
                          price: item['price'].toString(),
                          desc: item['description'],
                          stock: item['stock'].toString(),
                        ),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IMAGE
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                item['thumbnail'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
                            child: Text(
                              item['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '\$${item['price']}',
                              style: const TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

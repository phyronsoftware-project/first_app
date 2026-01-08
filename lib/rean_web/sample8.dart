import 'package:first_app/rean_web/models/name_class.dart';
import 'package:first_app/rean_web/sample5_1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Sample8 extends StatefulWidget {
  const Sample8({super.key});

  @override
  State<Sample8> createState() => _Sample8State();
}

class _Sample8State extends State<Sample8> {
  // List data = [];
  var check = false;

  List<Data> data = [];
  Future<List> fetchData() async {
    var url = Uri.parse('https://dummyjson.com/products/category/smartphones');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // final list = jsonDecode(response.body)['products'] as List;
      // setState(() {
      //   data = list;
      //   check = true;
      // });
      // return list;
      var rs = jsonDecode(response.body)['products'] as List;
      for (var element in rs) {
        data.add(
          Data(
            id: element['id'],
            name: element['title'],
            img: element['thumbnail'],
            price: element['price'].toDouble(),
            desc: element['description'],
            stock: element['stock'].toString(),
          ),
        );
      }
      return rs;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
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
        title: const Text('Future Builder'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          // 1️⃣ Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // 2️⃣ Error state
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // 3️⃣ Success state
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return GridView.builder(
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
            );
          }

          // 4️⃣ Fallback
          return const Text('No data');
        },
      ),
    );
  }
}

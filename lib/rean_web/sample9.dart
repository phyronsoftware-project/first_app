import 'package:first_app/rean_web/sample5_1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Sample9 extends StatefulWidget {
  const Sample9({super.key});

  @override
  State<Sample9> createState() => _Sample9State();
}

class _Sample9State extends State<Sample9> {
  List data = [];
  var check = false;
  int skip = 0;
  final int limit = 10;

  late Future<List> future;

  Future<List> fetchData() async {
    var url = Uri.parse(
      'https://dummyjson.com/products/category/smartphones?skip=$skip&limit=$limit',
    );
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final list = jsonDecode(response.body)['products'] as List;
      setState(() {
        data = list;
        check = true;
      });
      return list;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    future = fetchData();
  }

  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    try {
      skip = 0;
      final list = await fetchData(); // ✅ fetch again
      setState(() {
        data = list;
      });
      _refreshController.refreshCompleted();
      _refreshController.resetNoData();
    } catch (e) {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    try {
      skip += limit;

      final url = Uri.parse(
        'https://dummyjson.com/products/category/smartphones?skip=$skip&limit=$limit',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final list = jsonDecode(response.body)['products'] as List;

        if (list.isEmpty) {
          _refreshController.loadNoData();
          return;
        }

        setState(() {
          data.addAll(list); // ✅ append
        });

        _refreshController.loadComplete();
      } else {
        _refreshController.loadFailed();
      }
    } catch (e) {
      _refreshController.loadFailed();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Builder'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List>(
        future: future,
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
            // ✅ use your state data (not snapshot.data)
            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
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
            );
          }

          // 4️⃣ Fallback
          return const Text('No data');
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Test1 extends StatefulWidget {
  const Test1({super.key});

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  var myData = ["Facebook", "Twitter", "Instagram", "LinkedIn"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test1 Page')),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Add Social Media',
                prefixIcon: Icon(Icons.person_add),
              ),
              onSubmitted: (value) {
                setState(() {
                  myData.add(value);
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: double.maxFinite,
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: myData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(myData[index]),
                  leading: const Icon(Icons.account_circle),
                  subtitle: const Text('Social Media Platform'),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        myData.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

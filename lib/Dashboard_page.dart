import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productap/Detail_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

var data;
Future<void> getApi() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')); // Fixed the URL
  if (response.statusCode == 200) {
    data = jsonDecode(response.body.toString());
  } else {
    // Handle error if needed
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2c4cff),
        title: Text(
          'Dashboard Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onDoubleTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                )
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 300,
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReusableRow(
                                        title: 'Id',
                                        value: data[index]['id'].toString(),
                                      ),
                                      ReusableRow(
                                        title: 'Slug',
                                        value: data[index]['slug'] .toString() ,
                                      ),
                                      ReusableRow(
                                        title: 'Title',
                                        value: data[index]['title'].toString(),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 75,
                                        child: Center(child: Text("Category")),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  height: 25,
                                  width: 75,
                                  color: Colors.green,
                                  child: Center(
                                    child: Text("Status", style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: Container(
                                  height: 25,
                                  width: 95,
                                  color: Colors.green,
                                  child: Center(
                                    child: Text("PublishedAt", style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 1,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

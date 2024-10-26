import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productap/Detail_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

Future<List<dynamic>> getUserApi() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.org/posts')); // Fixed the URL
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    return [];
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: '     Search',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Stack(children: [
                                GestureDetector(onTap: () {
                                  // Pass data for the specific card to DetailPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        data: snapshot.data![index], // Pass the data of the tapped card
                                      ),
                                    ),
                                  );
                                },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 200,
                                            width: 160,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    image: NetworkImage(snapshot
                                                        .data![index]['image']),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: Stack(children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Text(
                                                      'ID: ${snapshot.data![index]['id']}',style: TextStyle(fontSize: 15),),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                      'Slug: ${snapshot.data![index]['slug']}',style: TextStyle(fontSize: 15),),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                      'Title: ${snapshot.data![index]['title']}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,style: TextStyle(fontSize: 15),),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Content: ${snapshot.data![index]['content']}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 15), ),
                                                  SizedBox(
                                                    height: 10,

                                                  ),Text(
                                                    'Category: ${snapshot.data![index]['category']}',
                                                    maxLines: 1,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: TextStyle(fontSize: 15), ),
                                                  SizedBox(
                                                    height: 30,

                                                  ),

                                                ],
                                              ),
                                              Positioned(
                                                right: 5,
                                                top: 2,
                                                child: Container(
                                                  height: 25,
                                                  width: 80,
                                                  child: Center(
                                                    child: Text(
                                                      "Status",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                ),
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 18,
                                  bottom: 18,
                                  child: Container(
                                    height: 25,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        "PublishedAt",
                                        style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(

                                        borderRadius:
                                            BorderRadius.circular(8),border: Border.all(color: Colors.green,width: 1)),
                                  ),
                                )
                              ]),
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}

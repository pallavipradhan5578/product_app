import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final dynamic data; // Accept data dynamically

  DetailPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"),backgroundColor: const Color(0xff2c4cff),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Stack(
              children: [Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child:  Image.network(
                    data['image'],
                    height: MediaQuery.of(context).size.width / 2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                    // Set height as desired
                    color: Colors.blue,
                  ),SizedBox(height: 20,),
                  Text('ID: ${data['id']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300),),

                  Text('Slug: ${data['slug']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300)),
                  Text('Title: ${data['title']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700)),
                  Text('Content: ${data['content']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300)),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
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
              ),]
            ),
          ),
        ),
      ),
    );
  }
}

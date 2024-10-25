import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2c4cff),
          title: Text("Detail Page"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            child: Column(
              children: [
                Stack(children: [
                  Container(
                    color: Color(0xff2c4cff),
                    height: MediaQuery.of(context).size.height /2,
                  ),Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      height: 25,
                      width: 75,
                      color: Colors.green,
                      child: Center(
                        child: Text("Status", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ]),

              ],
            ),
          ),
        ));
  }
}

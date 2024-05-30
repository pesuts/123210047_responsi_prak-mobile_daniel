import 'package:flutter/material.dart';
import 'package:responsi_123210047/view/ListAgentView.dart';

import 'ListMapView.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Main Page",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // print("clicked");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListAgentView(),
                  ));
            },
            child: Card(
              color: Colors.red,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 5),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 5),
                    child: Text(
                      "Agents",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          InkWell(
            onTap: () {
              // print("clicked");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListMapView(),
                  ));
            },
            child: Card(
              color: Colors.red,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 160, vertical: 5),
                    child: Icon(
                      Icons.map,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 160, vertical: 5),
                    child: Text(
                      "Maps",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsi_123210047/view/Home.dart';
import 'package:responsi_123210047/view/ListAgentView.dart';

// NAMA : DANIEL HASIANDO SINAGA
// NIM : 123210047
// KELAS : IF - E

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      // home: ListAgentView(),
    );
  }
}

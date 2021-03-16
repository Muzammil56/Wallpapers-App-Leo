import 'package:flutter/material.dart';
import 'package:wallapaers_leo/views/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wallpapers Leo',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'FiraSans',
      ),
      home: Home(),
    );
  }
}
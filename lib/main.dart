import 'package:flutter/material.dart';
import 'package:noticias_examen_app/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Noticias - Examen - App'),
          backgroundColor: Colors.orange,
        ),
        body: HomeScreen(), 
      ),
    );
  }
}
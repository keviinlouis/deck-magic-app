import 'package:deckmagic/views/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Magical Deck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeckView(),
    );
  }
}
import 'package:deckmagic/states/deck_state.dart';
import 'package:deckmagic/views/home.dart';
import 'package:deckmagic/views/search_card_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DeckState())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color(0xFF7e502e),
          accentColor: Colors.white
        ),
        home: DeckView(),
        routes: {
          '/search': (_) => SearchCardView(),
        },
      ),
    );
  }
}

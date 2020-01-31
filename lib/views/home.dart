import 'package:deckmagic/models/card_model.dart';
import 'package:deckmagic/states/deck_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_item.dart';

class DeckView extends StatefulWidget {
  @override
  _DeckViewState createState() => _DeckViewState();
}

class _DeckViewState extends State<DeckView> {
  void navigateToSearchCardView() async {
    await Navigator.of(context).pushNamed('/search');
    Provider.of<DeckState>(context, listen: false).searchList = [];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontFamily: 'Magic',
    );
    return Scaffold(
      backgroundColor: Color(0xFF7e502e),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'My Deck',
            style: titleStyle,
          ),
        ),
        actions: <Widget>[
          Consumer<DeckState>(
            builder: (_, state, __) => Text(
              "(${state.deck.length})",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: navigateToSearchCardView,
              title: Text('Search Cards'),
              trailing: Icon(Icons.search),
            ),
            Expanded(
              child: Consumer<DeckState>(builder: (_, state, __) {
                return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                  children: buildCardItems(state.deck),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  buildCardItems(List<CardModel> deck) {
    return deck
        .map((card) => CardItem(
            cardModel: card,
            action: FlatButton(
              onPressed: () {
                Provider.of<DeckState>(context, listen: false)
                    .toggleCardToDeck(card);
                Navigator.of(context).pop();
              },
              child: Text('REMOVE FROM DECK'),
            )))
        .toList();
  }
}

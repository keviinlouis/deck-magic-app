import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:deckmagic/models/card_model.dart';
import 'package:deckmagic/states/deck_state.dart';
import 'package:deckmagic/views/card_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class SearchCardView extends StatefulWidget {
  @override
  _SearchCardViewState createState() => _SearchCardViewState();
}

class _SearchCardViewState extends State<SearchCardView> {
  TextEditingController searchController = TextEditingController();
  bool showClearIcon = false;
  Timer _debounce;
  String searchedName;
  CardModel selectedCard;

  get selectedCardInDeck {
    if (selectedCard == null) return false;

    List deck = Provider.of<DeckState>(context, listen: false).deck;

    return deck.contains(selectedCard);
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      if (!showClearIcon && searchController.text.isNotEmpty) {
        setState(() {
          showClearIcon = true;
        });
      }

      if (showClearIcon && searchController.text.isEmpty) {
        setState(() {
          showClearIcon = false;
        });
      }

      _onSearchChanged();
    });
  }

  _onSearchChanged() {
    if (searchController.text.isEmpty) return;

    if (searchedName == searchController.text) return;

    searchedName = searchController.text;

    if (_debounce?.isActive ?? false) _debounce.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), search);
  }

  void search() async {
    Provider.of<DeckState>(context, listen: false)
        .searchCardByName(searchController.text);
  }

  void toggleInDeck() {
    if (selectedCard == null) return;

    Provider.of<DeckState>(context, listen: false)
        .toggleCardToDeck(selectedCard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7e502e),
      appBar: AppBar(
        leading: BackButton(
          color: Color(0xFF7e502e),
        ),
        backgroundColor: Colors.white,
        title: buildSearchField(),
      ),
      body: buildSearchContent(),
    );
  }

  buildSearchField() {
    Widget icon = showClearIcon
        ? IconButton(
            onPressed: () => searchController.clear(),
            icon: Icon(Icons.close, color: Color(0xFF7e502e)),
          )
        : Icon(
            Icons.search,
            color: Color(0xFF7e502e),
          );

    return TextField(
      autofocus: true,
      style: TextStyle(color: Color(0xFF7e502e)),
      controller: searchController,
      cursorColor: Color(0xFF7e502e),
      decoration: InputDecoration(
        labelText: 'Search by Name',
        labelStyle: TextStyle(color: Color(0xFF7e502e), fontWeight: FontWeight.bold),
        focusColor: Color(0xFF7e502e),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7e502e)),
        ),
        suffixIcon: icon,
      ),
    );
  }

  buildSearchContent() {
    return SafeArea(
      child: Consumer<DeckState>(
        builder: (_, state, __) {
          if (state.busy)
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ));

          if (state.searchList.isEmpty) return Container();

          Size size = MediaQuery.of(context).size;

          if(selectedCard == null) selectedCard = state.searchList.first;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: CarouselSlider(
                  items: buildCardItems(state.searchList),
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  height: size.height * 0.55,
                  onPageChanged: (index) =>
                      setState(() => selectedCard = state.searchList[index]),
                ),
              ),
              OutlineButton(
                borderSide: BorderSide(width: 1, color: Colors.white),
                onPressed: toggleInDeck,
                child: Text(selectedCardInDeck
                    ? 'REMOVE CARD FROM DECK'
                    : 'ADD CARD TO DECK'),
                highlightColor: Colors.orange,
              )
            ],
          );
        },
      ),
    );
  }

  List<Widget> buildCardItems(List<CardModel> searchList) {
    return searchList.map(
      (card) {
        return CardItem(
          cardModel: card,
          action: FlatButton(
            onPressed: () {
              Provider.of<DeckState>(context, listen: false)
                  .toggleCardToDeck(card);
              Navigator.of(context).pop();
            },
            child: Text(selectedCardInDeck
                ? 'REMOVE CARD FROM DECK'
                : 'ADD CARD TO DECK'),
          ),
        );
      },
    ).toList();
  }
}

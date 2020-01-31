import 'package:deckmagic/models/card_model.dart';
import 'package:deckmagic/services/magic_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DeckState extends ChangeNotifier {
  List<CardModel> searchList = [];
  List<CardModel> deck = [];
  CardModel _card;

  bool _busy = false;

  bool loaded = false;

  bool get busy => _busy;

  set busy(bool busy) {
    _busy = busy;
    notifyListeners();
  }

  CardModel get card => _card;

  set card(CardModel card) {
    _card = card;
    notifyListeners();
  }

  toggleCardToDeck(CardModel card) {
    if(deck.contains(card)){
      deck.remove(card);
    }else{
      deck.add(card);
    }
    notifyListeners();
  }

  removeCardFromDeck(CardModel card) {
    removeCardFromDeckById(card.id);
  }

  removeCardFromDeckById(String id) {
    deck.removeWhere((cardInDeck) => cardInDeck.id == id);
    notifyListeners();
  }

  searchCardByName(String name) async {
    busy = true;

    MagicApi api = MagicApi();

    Response response = await api.searchCardByName(name);

    Map<String, dynamic> data = response.data;

    List cards = data["cards"];

    cards.removeWhere((card) => card['imageUrl'] == null);

    this.searchList = cards
        .map((cardFromResponse) => CardModel.fromJson(cardFromResponse))
        .toList();

    loaded = true;

    busy = false;
  }
}

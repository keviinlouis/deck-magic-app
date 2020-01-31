import 'foreign_name_model.dart';
import 'ruling_model.dart';

class CardModel {
  String id;
  String name;
  List<String> names;
  String manaCost;
  int cmc;
  List<String> colors;
  List<String> colorIdentity;
  String type;
  List<String> supertypes;
  List<String> types;
  List<String> subtypes;
  String rarity;
  String set;
  String text;
  String artist;
  String number;
  String power;
  String toughness;
  String layout;
  int multiverseid;
  String imageUrl;
  List<Ruling> rulings;
  List<ForeignName> foreignNames;
  List<String> printings;
  String originalText;
  String originalType;
  int position;

  CardModel(
      {this.name,
        this.names,
        this.manaCost,
        this.cmc,
        this.colors,
        this.colorIdentity,
        this.type,
        this.supertypes,
        this.types,
        this.subtypes,
        this.rarity,
        this.set,
        this.text,
        this.artist,
        this.number,
        this.power,
        this.toughness,
        this.layout,
        this.multiverseid,
        this.imageUrl,
        this.rulings,
        this.foreignNames,
        this.printings,
        this.originalText,
        this.originalType,
        this.id});

  CardModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    names = json['names'].cast<String>();
    manaCost = json['manaCost'];
    cmc = json['cmc'];
    colors = json['colors'].cast<String>();
    colorIdentity = json['colorIdentity'].cast<String>();
    type = json['type'];
    supertypes = json['supertypes'].cast<String>();
    types = json['types'].cast<String>();
    subtypes = json['subtypes'].cast<String>();
    rarity = json['rarity'];
    set = json['set'];
    text = json['text'];
    artist = json['artist'];
    number = json['number'];
    power = json['power'];
    toughness = json['toughness'];
    layout = json['layout'];
    multiverseid = json['multiverseid'];
    imageUrl = json['imageUrl'];
    if (json['rulings'] != null) {
      rulings = new List<Ruling>();
      json['rulings'].forEach((v) {
        rulings.add(new Ruling.fromJson(v));
      });
    }
    if (json['foreignNames'] != null) {
      foreignNames = new List<ForeignName>();
      json['foreignNames'].forEach((v) {
        foreignNames.add(new ForeignName.fromJson(v));
      });
    }
    printings = json['printings'].cast<String>();
    originalText = json['originalText'];
    originalType = json['originalType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['names'] = this.names;
    data['manaCost'] = this.manaCost;
    data['cmc'] = this.cmc;
    data['colors'] = this.colors;
    data['colorIdentity'] = this.colorIdentity;
    data['type'] = this.type;
    data['supertypes'] = this.supertypes;
    data['types'] = this.types;
    data['subtypes'] = this.subtypes;
    data['rarity'] = this.rarity;
    data['set'] = this.set;
    data['text'] = this.text;
    data['artist'] = this.artist;
    data['number'] = this.number;
    data['power'] = this.power;
    data['toughness'] = this.toughness;
    data['layout'] = this.layout;
    data['multiverseid'] = this.multiverseid;
    data['imageUrl'] = this.imageUrl;
    if (this.rulings != null) {
      data['rulings'] = this.rulings.map((v) => v.toJson()).toList();
    }
    if (this.foreignNames != null) {
      data['foreignNames'] = this.foreignNames.map((v) => v.toJson()).toList();
    }
    data['printings'] = this.printings;
    data['originalText'] = this.originalText;
    data['originalType'] = this.originalType;
    data['id'] = this.id;
    return data;
  }
}
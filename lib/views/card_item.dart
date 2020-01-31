import 'package:cached_network_image/cached_network_image.dart';
import 'package:deckmagic/models/card_model.dart';
import 'package:deckmagic/views/photo_viewer.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final CardModel cardModel;
  final Widget action;

  const CardItem({Key key, this.cardModel, this.action}) : super(key: key);

  openImage(context) {
    if (cardModel.imageUrl == null) return;

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return PhotoViewer(
        actions: <Widget>[action],
        image: NetworkImage(cardModel.imageUrl),
        heroTag: cardModel.id.toString(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardModel.id.toString(),
      child: GestureDetector(
        onTap: () => openImage(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl: cardModel.imageUrl,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

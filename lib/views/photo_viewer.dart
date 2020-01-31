import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  final ImageProvider image;
  final List<Widget> actions;
  final String heroTag;

  const PhotoViewer({
    Key key,
    this.image,
    this.actions = const [],
    this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: actions,
      ),
      body: Container(
        child: PhotoView(
          minScale: 0.3,
          maxScale: 1.5,
          imageProvider: image,
          heroAttributes: PhotoViewHeroAttributes(tag: heroTag ?? ''),
          loadingChild: buildLoading(),
        ),
      ),
    );
  }

  buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

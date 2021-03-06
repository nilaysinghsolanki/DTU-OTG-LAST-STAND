import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GalleryView extends StatelessWidget {
  static const routeName = '/GalleryView';
  String uri;
  @override
  Widget build(BuildContext context) {
    uri = ModalRoute.of(context).settings.arguments;
    return Container(
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(uri),
      ),
    );
  }
}

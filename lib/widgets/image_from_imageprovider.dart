import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<Widget> imageWidgetFromUrl(BuildContext context, String imageUrl) async {
  return ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    child: CachedNetworkImage(
      imageUrl: "https://algol.dev/wp-content/uploads/2021/04/flutter-04.png",
      width: MediaQuery.of(context).size.width / 3.1,
      height: MediaQuery.of(context).size.height / 6.6,
      fit: BoxFit.cover,
    ),
    /*width: MediaQuery.of(context).size.width / 3.1,
    height: MediaQuery.of(context).size.height / 6.6,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: const
      image: DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(imageUrl)),
    ),*/
  );
}

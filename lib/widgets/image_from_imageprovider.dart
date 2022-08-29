import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<Widget> imageWidgetFromImageProvider(
    BuildContext context, ImageProvider imageProvider) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final File file = new File("${appDocDir}/images/1.jpg");
  ImageProvider futureImageProvider = await imageProvider;

  return Container(
      /*width: MediaQuery.of(context).size.width / 3.1,
      height: MediaQuery.of(context).size.height / 6.6,*/
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        image: DecorationImage(fit: BoxFit.cover, image: FileImage(file)),
      ));
}

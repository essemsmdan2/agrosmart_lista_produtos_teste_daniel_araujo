import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<String> loadImageReturnUrl(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child("images/$image").getDownloadURL();
  }

  static Future<String> loadImageDownload(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child("images/$image").getDownloadURL();
  }
}

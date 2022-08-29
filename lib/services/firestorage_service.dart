import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<String> loadRepositoryReturnUrlRepository(String produtoFilename) async {
    String test =
        await FirebaseStorage.instance.ref().child("images/$produtoFilename").getDownloadURL();
    print("this is a test $test");

    return test;
  }
}

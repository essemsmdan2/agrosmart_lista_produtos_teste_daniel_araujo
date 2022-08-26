/*
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/api/db_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/produto_model.dart';

class ProdutoRepository extends ChangeNotifier {
  static List<dynamic> tabela = [
    Produto(image: "images/1.jpg", price: 10.51, rating: 1, title: 'Fresh bubbles', type: 'fruit'),
  ];

  late FirebaseFirestore db;

  ProdutoRepository() {
    _startRepository();
  }
  _startRepository() async {
    await _startFirestore();
    await _readDbRepository();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readDbRepository() async {
    if (_lista.isEmpty) {
      final agroSmartProductsFromGet = await db.collection('agrosmart_produtos').get();

      for (var product in agroSmartProductsFromGet.docs) {
        _lista.add(product.get("title"));
      }
      print(_lista);
      notifyListeners();
    }
  }

  remove(Produto produto) async {
    await db.collection("agrosmart_produto").doc(produto.title).delete();
    notifyListeners();
  }

  saveAll(List<dynamic> produtos) {
    produtos.forEach((produto) async {
      print(lista);
      if (!_lista.any((atual) => atual.title == produto.title)) {
        _lista.add(produto);
        await db.collection("agrosmart_produtos").doc(produto.title).set({"title": produto.title, "type": produto.type, "price": produto.price});
      }
    });
    notifyListeners();
  }
}
*/

import 'package:agrosmart_lista_produtos_teste_daniel_araujo/produtos_agrosmart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/produto_model.dart';

class FireStorageHandler extends ChangeNotifier {
  List<Produto> _listaProdutosFirestore = [];
  List<Produto> get listaProdutosFirestore => _listaProdutosFirestore;

  FireStorageHandler() {
    _startUpdateProdutosLoja();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference _firestorageCollectionAgroSmartProdutos =
      FirebaseFirestore.instance.collection('agrosmart_produtos');

  _startUpdateProdutosLoja() async {
    // getUpdatedFireStorageProducts();
    _firestorageCollectionAgroSmartProdutos.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        Map<String, dynamic> map = change.doc.data()! as Map<String, dynamic>;
        Produto produto = Produto.fromMap(map);
        if (change.type == DocumentChangeType.added) {
          _listaProdutosFirestore.add(produto);
        } else if (change.type == DocumentChangeType.modified) {
          int index = _listaProdutosFirestore
              .indexWhere((element) => element.filename == produto.filename);
          if (index < 0) {
            _listaProdutosFirestore.add(produto);
          } else {
            _listaProdutosFirestore[index] = produto;
          }
        } else if (change.type == DocumentChangeType.removed) {
          _listaProdutosFirestore
              .removeWhere((element) => element.filename == produto.filename);
        }
      }
      notifyListeners();
    });
  }

  Future<void> enviaProdutosParaBancoFirebase(
      List<Produto> listaProdutosAgrosmart) async {
    try {
      for (final produto in listaProdutosAgrosmart) {
        _firestorageCollectionAgroSmartProdutos
            .doc(produto.filename)
            .set(produto.toMap());
      }
    } catch (e) {
      print(e);
    }
  }

  removeProduto(Produto produto) async {
    await _firestorageCollectionAgroSmartProdutos
        .doc(produto.filename)
        .delete();
    _listaProdutosFirestore.remove(produto);
    notifyListeners();
  }

  atualizaValorProduto(
      Produto produto, String title, String type, String price) async {
    print(title);
    await _firestorageCollectionAgroSmartProdutos
        .doc(produto.filename)
        .update({"title": title, "type": type, "price": int.parse(price)});
    //await getUpdatedFireStorageProducts();
    notifyListeners();
  }
}

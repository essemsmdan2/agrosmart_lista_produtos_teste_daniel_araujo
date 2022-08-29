import 'dart:io';

import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firestore_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/products_cards_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final storageRef = FirebaseStorage.instance.ref();

  void downloadToCacheAllFireStorageImgs() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    print(appDocDir.path);
    print("this one");
    final filePath = "${appDocDir.path}/images/1.jpg";
    final file = File(filePath);

    final islandRef = storageRef.child("images/1.jpg");
    final downloadTask = islandRef.writeToFile(file);
    downloadTask.snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          print('running');
          break;
        case TaskState.paused:
          // TODO: Handle this case.
          break;
        case TaskState.success:
          print('sucess');
          break;
        case TaskState.canceled:
          // TODO: Handle this case.
          break;
        case TaskState.error:
          print('n deu');
          break;
      }
    });
  }

  @override
  void initState() {
    //FireStorageHandler().enviaProdutosParaBancoFirebase();
    downloadToCacheAllFireStorageImgs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            Consumer<FirestoreRepository>(builder: (BuildContext context, products, Widget? child) {
          return products.listaProdutosFirestore.isEmpty
              ? const ListTile(
                  leading: Icon(Icons.remove_shopping_cart_rounded),
                  title: Text('Ainda não há Produtos'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, int index) {
                    return ProductCard(
                      key: Key("productCards"),
                      produto: products.listaProdutosFirestore[index],
                    );
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: products.listaProdutosFirestore.length);
        }),
      ),
    );
  }
}

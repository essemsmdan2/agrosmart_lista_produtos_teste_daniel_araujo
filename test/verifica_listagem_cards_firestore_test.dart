import 'package:agrosmart_lista_produtos_teste_daniel_araujo/models/produto_model.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firestore_repository.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/produtos_agrosmart.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/screens/main_screen.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

List<Produto> listadeProdutos = ProdutosAgroSmart.mappedListaProdutosTest;
const String produtosCollection = "agrosmart_produtos";

void main() {
  testWidgets('shows messages', (WidgetTester tester) async {
    // Populate the fake database.

    final firestore = FakeFirebaseFirestore();

    for (Produto produto in listadeProdutos) {
      await firestore
          .collection(produtosCollection)
          .doc(produto.filename)
          .set(await produto.toMapTest());
    }

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => FirestoreRepository(firestore: firestore)),
      ],
      child: const MaterialApp(
        home: MainScreen(),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text("Green smoothie"), findsOneWidget);
  });
}

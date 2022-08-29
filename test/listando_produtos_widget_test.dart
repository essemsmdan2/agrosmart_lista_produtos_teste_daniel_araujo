import 'package:agrosmart_lista_produtos_teste_daniel_araujo/firebase_options.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/mock.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/repositories/firestore_repository.dart';
import 'package:agrosmart_lista_produtos_teste_daniel_araujo/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() async {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets("verifica a listagem dos produtos", (WidgetTester tester) async {
    final productCard = find.byKey(ValueKey("productCard"));

    //execute
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirestoreRepository()),
      ],
      child: MaterialApp(
        home: MainScreen(),
      ),
    ));
    await tester.pump(Duration(seconds: 5));

    //check outputs
    expect(productCard, findsWidgets);
  });
}

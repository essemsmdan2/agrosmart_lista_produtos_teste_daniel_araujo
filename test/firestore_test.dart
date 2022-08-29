import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseFirestoreMock extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock implements Future<DocumentSnapshot<Map<String, dynamic>>> {}

void main() {
  FirebaseFirestoreMock instance = FirebaseFirestoreMock();
  MockCollectionReference mockCollectionReference = MockCollectionReference();
  MockDocumentReference mockDocumentReference = MockDocumentReference();
  MockDocumentSnapshot mockDocumentSnapshot = MockDocumentSnapshot();

  test('should return data when the call to remote source is successful.', () async {
    when(() => instance.collection(any())).thenReturn(mockCollectionReference);
    when(() => mockCollectionReference.doc(any())).thenReturn(mockDocumentReference);
    when(() => mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
    when(() async => await mockDocumentSnapshot.asStream().listen((event) {}))
        .thenReturn(responseMap);
    //act

    //assert
  });
}

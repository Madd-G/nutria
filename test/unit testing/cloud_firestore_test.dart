import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore instance;

  // Define the setUp function.
  setUp(() async {
    instance = FakeFirebaseFirestore();
    await instance.collection('article').add({
      'author': 'Madd',
      'title': 'The title',
      'article': 'The article',
      'viewed': 1,
    });
  });

  test('Cek dokumen value', () async {
    // Use the instance variable instead of creating a new instance.
    final docRef = instance.doc('article/8GcLwU769Bkb2N5gWf5v');
    await docRef.set({
      'author': 'Madd',
      'title': 'The title',
      'article': 'The article',
      'viewed': 1,
    });

    expect((await docRef.get())['author'], equals('Madd'));
  });

  test('Update dokumen value', () async {
    // Use the instance variable instead of creating a new instance.
    final doc = instance.collection('article').doc('uid');
    await doc.set({
      'author': 'Madd',
      'title': 'The title',
      'article': 'The article',
      'viewed': 1,
    });

    var viewed =
        (await instance.collection('article').get()).docs.first.get('viewed');
    await doc.update({'viewed': viewed + 1});
    expect((await doc.get()).get('viewed'), equals(2));
  });
}

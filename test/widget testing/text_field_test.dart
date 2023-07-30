import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseAuthMocks();
    await Firebase.initializeApp(
      name: 'text field test',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });
  testWidgets(
    'Menginputkan teks "hallo" pada TextField',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'hallo');
      final enteredText =
          (tester.widget(find.byType(TextField)) as TextField).controller!.text;
      expect(enteredText, equals('hallo'));
    },
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() async {
  setUpAll(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setupFirebaseAuthMocks();
      await Firebase.initializeApp(
        name: 'card test',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );

  testWidgets(
    'Warna Card pada mode terang adalah Color(0xFF424242)',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(
        themeData: ThemeData.light(),
      ));
      final containerFinder = find.byKey(const Key('category-card'));
      final renderedText = tester.widget<Card>(containerFinder.first).color;
      expect(renderedText, equals(const Color(0xFF424242)));
    },
  );

  testWidgets(
    'Warna Card pada mode gelap adalah Color(0xFFFFFFFF)',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.dark(),
        ),
      );
      final containerFinder = find.byKey(const Key('category-card'));
      final renderedText = tester.widget<Card>(containerFinder.first).color;
      expect(renderedText, equals(const Color(0xFFFFFFFF)));
    },
  );
}

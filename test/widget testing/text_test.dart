import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() async {
  setUpAll(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setupFirebaseAuthMocks();
      await Firebase.initializeApp(
        name: 'text test',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );

  testWidgets(
    'Pengujian style teks sapaan',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.light(),
        ),
      );

      final textFinder = find.byKey(const Key('greeting_text'));

      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);

      final textSize = textWidget.style?.fontSize;
      final textWeight = textWidget.style?.fontWeight;

      expect(textSize, 35.0);
      expect(textWeight, FontWeight.w900);
    },
  );

  testWidgets(
    'Warna teks pada mode terang adalah hitam',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(
        themeData: ThemeData.light(),
      ));
      final textWidget = find.byKey(const Key('greeting_text'));
      final renderedText = tester.widget<Text>(textWidget);
      expect(renderedText.style?.color, Colors.black);
    },
  );
  testWidgets(
    'Warna teks pada mode gelap adalah putih ',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.dark(),
        ),
      );
      final textWidget = find.byKey(const Key('greeting_text'));
      final renderedText = tester.widget<Text>(textWidget);
      expect(renderedText.style?.color, Colors.white);
    },
  );

  testWidgets(
    'Sapaan pada pagi hari adalah "SELAMAT PAGI"',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.light(),
          fakeHour: 7,
        ),
      );
      final textFinder = find.byKey(const Key('greeting_text'));
      final textWidget = tester.widget<Text>(textFinder);
      final text = textWidget.data;
      expect(text, 'SELAMAT PAGI');
    },
  );

  testWidgets(
    'Sapaan pada siang hari adalah "SELAMAT SIANG"',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.light(),
          fakeHour: 17,
        ),
      );
      final textFinder = find.byKey(const Key('greeting_text'));
      final textWidget = tester.widget<Text>(textFinder);
      final text = textWidget.data;
      expect(text, 'SELAMAT SIANG');
    },
  );

  testWidgets(
    'Sapaan pada malam hari adalah "SELAMAT MALAM"',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.light(),
          fakeHour: 20,
        ),
      );

      final textFinder = find.byKey(const Key('greeting_text'));
      final textWidget = tester.widget<Text>(textFinder);
      final text = textWidget.data;
      expect(text, 'SELAMAT MALAM');
    },
  );
}

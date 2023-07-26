import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import '../../ios/.symlinks/plugins/cloud_firestore/test/mock.dart';

void main() async {
  setupCloudFirestoreMocks();
  setUpAll(
    () async {
      await Firebase.initializeApp(
        name: 'light mode test',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
  WidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'light mode test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        buildLightModeWidget(),
      );
      final textWidget = find.byKey(
        const Key(
          'light theme test',
        ),
      );
      final renderedText = tester.widget<Text>(textWidget);
      expect(renderedText.style?.color, Colors.black);
    },
  );
}

Widget buildLightModeWidget() {
  ThemeData lightTheme = ThemeData.light();
  return MaterialApp(
    theme: ThemeData.light(),
    home: Scaffold(
      body: Center(
        child: Text(
          'light mode test',
          style: TextStyle(
            color: (lightTheme.brightness == Brightness.light)
                ? Colors.black
                : Colors.white,
          ),
          key: const Key('light theme test'),
        ),
      ),
    ),
  );
}

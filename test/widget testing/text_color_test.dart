import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';

import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() async {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    setupFirebaseAuthMocks();
    await Firebase.initializeApp(
      name: 'upper test',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets(
    'Text color test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final textFinder = find.byKey(const Key('widget_test'));

      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      final textColors = textWidget.style?.color;

      // verify that the text is white
      expect(textColors, Colors.black);
    },
  );
}

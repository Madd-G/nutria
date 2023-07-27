import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
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
    'Light mode test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      final textWidget = find.byKey(const Key('widget_test'));
      final renderedText = tester.widget<Text>(textWidget);
      expect(renderedText.style?.color, Colors.black);
    },
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() async {
  setUpAll(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setupFirebaseAuthMocks();
      await Firebase.initializeApp(
        name: 'dark test',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );

  testWidgets(
    'Dark mode test',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildDarkModeWidget());
      final textWidget = find.byKey(const Key('dark theme test'));
      final renderedText = tester.widget<Text>(textWidget);
      expect(renderedText.style?.color, Colors.white);
    },
  );
}

Widget buildDarkModeWidget() {
  ThemeData darkTheme = ThemeData.dark();
  return MaterialApp(
    theme: ThemeData.dark(),
    home: Scaffold(
      body: Center(
        child: Text(
          'Dark mode test',
          style: TextStyle(
              color: (darkTheme.brightness == Brightness.dark)
                  ? Colors.white
                  : Colors.black),
          key: const Key('dark theme test'),
        ),
      ),
    ),
  );
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import 'package:nutria/ui/chat_screen/screen/chat_screen.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() {
  setUp(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      setupFirebaseAuthMocks();
      await Firebase.initializeApp(
        name: 'fab test',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
  testWidgets(
    'Test Floating Action Button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MyApp(
          themeData: ThemeData.dark(),
        ),
      );

      final fabFinder = find.byKey(const Key('fab-key'));
      final FloatingActionButton floatingActionButton =
          tester.widget(fabFinder) as FloatingActionButton;
      final ThemeData themeData = Theme.of(tester.element(fabFinder));

      expect(fabFinder, findsOneWidget);
      expect(floatingActionButton.backgroundColor,
          equals(themeData.colorScheme.primary));
          // equals(const Color(0xff2196f3)));

      await tester.tap(fabFinder);
      await tester.pumpAndSettle();
      expect(find.byType(ChatScreen), findsOneWidget);
    },
  );
}

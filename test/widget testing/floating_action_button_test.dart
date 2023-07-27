import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupFirebaseAuthMocks();
    await Firebase.initializeApp(
      name: 'fab test',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });
  testWidgets('Test Floating Action Button Navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final fabFinder = find.byTooltip('Go to chat');

    expect(fabFinder, findsOneWidget);
  });
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() {
  testWidgets('Test FloatingActionButton onPressed',
      (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();
    setupFirebaseAuthMocks();
    await Firebase.initializeApp(
      name: 'fab test',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Create a GlobalKey to use as the key for the FloatingActionButton
    final Key fabKey = GlobalKey();

    // A variable to track if the onPressed function is called
    bool onPressedCalled = false;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
        // fabKey: fabKey,
        // onPressedCallback: () {
        //   onPressedCalled = true;
        // },
        ));

    // Find the Floating Action Button by its key
    final Finder fabFinder = find.byKey(const Key('fab-key'));

    // Verify the presence of the Floating Action Button
    expect(fabFinder, findsOneWidget);

    // Tap the Floating Action Button
    await tester.tap(fabFinder);

    // Wait for the animation to complete
    await tester.pumpAndSettle(const Duration(seconds: 10));

    // Verify that the onPressed function is called
    expect(onPressedCalled, true);
  });
}

// class MyApp extends StatelessWidget {
//   final Key? fabKey;
//   final VoidCallback? onPressedCallback;
//
//   MyApp({this.fabKey, this.onPressedCallback});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('FAB Test')),
//         floatingActionButton: FloatingActionButton(
//           key: fabKey, // Assign the key to the FloatingActionButton
//           onPressed: onPressedCallback, // Assign the onPressed function
//           tooltip: 'Add',
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

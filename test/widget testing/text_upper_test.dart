import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
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
    'Text upper test',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final textFinder = find.byKey(const Key('widget_test'));

      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      final text = textWidget.data;
      expect(text, 'GOOD AFTERNOON');
    },
  );

  // testWidgets(
  //   'Text upper test',
  //   (WidgetTester tester) async {
  //     await tester.binding.setSurfaceSize(Size(360, 640));
  //     await tester.pumpWidget(MyApp());
  //
  //     final textFinder = find.byKey(const Key('widget_test'));
  //
  //     expect(textFinder, findsOneWidget);
  //
  //     BuildContext context = tester.element(textFinder);
  //     final textWidget = tester.widget<Text>(textFinder);
  //     final text = textWidget.data;
  //     final textColors = textWidget.style?.color;
  //     final textWeight = textWidget.style?.fontWeight;
  //     final textSize = textWidget.style?.fontSize;
  //     final height = context.size?.height;
  //     final width = context.size?.width;
  //
  //     expect(text, 'GOOD MORNING');
  //
  //     // verify that the text is black
  //     expect(textColors, Colors.white);
  //
  //     expect(textWeight, FontWeight.w900);
  //     expect(textSize, 22.0);
  //     if (Responsive.isMobile(context)) {
  //       expect(textSize, 22.0);
  //     } else {
  //       expect(textSize, 35.0);
  //     }
  //   },
  // );
}

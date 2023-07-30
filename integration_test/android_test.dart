import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import 'package:nutria/ui/article_screen/widgets/article_list_card.dart';
import 'package:nutria/ui/screens.dart';
import 'package:nutria/ui/home_screen/widgets/widgets.dart';
import 'package:nutria/ui/list_screen/widgets/product_card.dart';
import '../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  await Firebase.initializeApp(
    name: 'android_app_test',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  testWidgets('Android App Test', (WidgetTester tester) async {
    Finder articleTab = find.byKey(const Key('article_tab'));
    Finder homeTab = find.byKey(const Key('home_tab'));
    Finder vegetableTab = find.byKey(const Key('vegetable_tab'));
    Finder fruitTab = find.byKey(const Key('fruit_tab'));
    Finder fruitCategoryCard = find.byKey(const Key('fruit_category'));
    Finder vegetableGrid = find.byKey(const Key('vegetable-grid'));
    Finder fruitGrid = find.byKey(const Key('fruit-grid'));
    Finder characteristicsTab = find.byKey(const Key('Characteristics'));
    Finder nutritionTab = find.byKey(const Key('Nutrition'));
    Finder benefitsTab = find.byKey(const Key('Benefits'));
    Finder loginDialog = find.byKey(const Key('login-dialog'));
    Finder bottomSheet = find.byKey(const Key('bottom-sheet'));
    Finder changeLanguageButton = find.byKey(const Key('change-language'));
    Finder changeThemeButton = find.byKey(const Key('change-theme'));

    Finder backButton = find.byIcon(Icons.arrow_back_ios_new_outlined);
    Finder sendIcon = find.byIcon(Icons.send);

    Finder isOnHomeScreen = find.byType(HomeScreen);
    Finder isOnChatScreen = find.byType(ChatScreen);
    Finder isOnArticleScreen = find.byType(ArticleScreen);
    Finder floatingActionButton = find.byType(FloatingActionButton);
    Finder textField = find.byType(TextField);

    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(isOnHomeScreen, findsOneWidget);

    expect(floatingActionButton, findsOneWidget);

    await tester.tap(floatingActionButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(isOnChatScreen, findsOneWidget);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'Hallo');
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.text('Hallo'), findsOneWidget);

    expect(sendIcon, findsOneWidget);

    await tester.tap(sendIcon);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final enteredText =
        (tester.widget(find.byType(TextField)) as TextField).controller!.text;
    expect(enteredText, equals('Hallo'));
    await Future.delayed(const Duration(seconds: 2));

    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(isOnHomeScreen, findsOneWidget);
    expect(articleTab, findsOneWidget);

    await tester.tap(articleTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await Future.delayed(const Duration(seconds: 2));
    await tester.dragUntilVisible(
        find.text('Oranges: A Fresh Fruit Full of Vitamin C'),
        find.byKey(const Key('article-list-view')),
        const Offset(0, -300));
    expect(find.byType(ArticleListScreen), findsOneWidget);
    expect(find.byType(ArticleListCard), findsNWidgets(5));

    await tester.tap(find.text('Oranges: A Fresh Fruit Full of Vitamin C'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(isOnArticleScreen, findsOneWidget);
    expect(backButton, findsOneWidget);

    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(ArticleListScreen), findsOneWidget);
    expect(homeTab, findsOneWidget);

    await tester.tap(homeTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(isOnHomeScreen, findsOneWidget);
    expect(fruitCategoryCard, findsOneWidget);

    await tester.tap(fruitCategoryCard);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await Future.delayed(const Duration(seconds: 2));
    await tester.dragUntilVisible(
        find.text('Orange'), fruitGrid, const Offset(0, -300));

    expect(find.byType(ListScreen), findsOneWidget);
    expect(find.byType(ProductCard), findsNWidgets(8));
    expect(vegetableTab, findsOneWidget);

    await Future.delayed(const Duration(seconds: 3));

    await tester.tap(vegetableTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await Future.delayed(const Duration(seconds: 2));
    await tester.dragUntilVisible(
        find.text('Carrot'), vegetableGrid, const Offset(0, -300));

    expect(find.byType(ProductCard), findsNWidgets(8));
    expect(fruitTab, findsOneWidget);

    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(fruitTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(isOnHomeScreen, findsOneWidget);
    expect(find.text('Salak'), findsOneWidget);

    await tester.tap(find.text('Salak'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(DetailScreen), findsOneWidget);
    expect(characteristicsTab, findsOneWidget);

    await tester.tap(characteristicsTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(nutritionTab, findsOneWidget);

    await tester.tap(nutritionTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(benefitsTab, findsOneWidget);

    await tester.tap(benefitsTab);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(backButton, findsOneWidget);

    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await Future.delayed(const Duration(seconds: 3));

    expect(isOnHomeScreen, findsOneWidget);
    expect(loginDialog, findsOneWidget);

    await tester.tap(loginDialog);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(bottomSheet, findsOneWidget);
    expect(changeLanguageButton, findsOneWidget);

    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(changeLanguageButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byType(LanguageBottomSheet), findsOneWidget);
    expect(find.text('Indonesia'), findsOneWidget);

    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(find.text('Indonesia'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(backButton, findsOneWidget);

    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(changeThemeButton, findsOneWidget);

    await Future.delayed(const Duration(seconds: 3));
    await tester.tap(changeThemeButton);
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 2));

    await Future.delayed(const Duration(seconds: 4));
  });
}

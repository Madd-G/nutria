import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nutria/firebase_options.dart';
import 'package:nutria/main.dart';
import 'package:nutria/ui/article_screen/screens/article_list_screen.dart';
import 'package:nutria/ui/home_screen/screen/home_screen.dart';
import 'package:nutria/ui/scan_screen/screens/scan_screen.dart';
import '../../ios/.symlinks/plugins/firebase_auth/test/mock.dart';

void main() async {
  setUp(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();

      setupFirebaseAuthMocks();
      await Firebase.initializeApp(
        name: 'bottom navigation bar test',
        options: DefaultFirebaseOptions.currentPlatform,
      );
    },
  );
  testWidgets(
    'Test Bottom Navigation Bar',
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      print('Menampilkan halaman Beranda');
      expect(find.byKey(const Key('home_tab')), findsOneWidget);
      expect(find.byKey(const Key('scan_tab')), findsOneWidget);
      expect(find.byKey(const Key('article_tab')), findsOneWidget);
      final homeButtonStyle =
          tester.widget<GButton>(find.byKey(const Key('home_tab')));
      final scanButtonStyle =
          tester.widget<GButton>(find.byKey(const Key('scan_tab')));
      final articleButtonStyle =
          tester.widget<GButton>(find.byKey(const Key('article_tab')));

      print('Icon tombol BERANDA adalah ${Icons.home}');
      expect(homeButtonStyle.icon, Icons.home);

      print('Icon tombol PINDAI adalah ${Ionicons.scan_sharp}');
      expect(scanButtonStyle.icon, Ionicons.scan_sharp);

      print('Icon tombol ARTIKEL adalah ${Icons.article}');
      expect(articleButtonStyle.icon, Icons.article);

      print('Menekan tombol PINDAI');
      await tester.tap(find.byKey(const Key('scan_tab')));
      await tester.pumpAndSettle();
      print('Menampilkan halaman PINDAI');
      expect(find.byType(ScanScreen), findsOneWidget);

      print('Menekan tombol ARTIKEL');
      await tester.tap(find.byKey(const Key('article_tab')));
      await tester.pumpAndSettle(const Duration(seconds: 10));
      print('Menampilkan halaman DAFTAR ARTIKEL');
      expect(find.byType(ArticleListScreen), findsOneWidget);

      print('Menekan tombol BERANDA');
      await tester.tap(find.byKey(const Key('home_tab')));
      await tester.pumpAndSettle();
      print('Menampilkan halaman BERANDA');
      expect(find.byType(HomeScreen), findsOneWidget);
    },
  );
}

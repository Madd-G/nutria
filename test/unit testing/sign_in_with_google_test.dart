import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:test/test.dart';

void main() {
  late MockGoogleSignIn googleSignIn;
  setUp(
    () {
      googleSignIn = MockGoogleSignIn();
    },
  );

  test(
    'harus mengembalikan idToken dan accessToken ketika mengotentikasi',
    () async {
      final signInAccount = await googleSignIn.signIn();
      final signInAuthentication = await signInAccount!.authentication;
      expect(signInAuthentication, isNotNull);
      expect(googleSignIn.currentUser, isNotNull);
      expect(signInAuthentication.accessToken, isNotNull);
      expect(signInAuthentication.idToken, isNotNull);
    },
  );

  test(
    'harus mengembalikan null ketika login dibatalkan oleh user',
    () async {
      googleSignIn.setIsCancelled(true);
      final signInAccount = await googleSignIn.signIn();
      expect(signInAccount, isNull);
    },
  );
  test(
    'login dibatalkan, kemudian login kembali',
    () async {
      googleSignIn.setIsCancelled(true);
      final signInAccount = await googleSignIn.signIn();
      expect(signInAccount, isNull);
      googleSignIn.setIsCancelled(false);
      final signInAccountSecondAttempt = await googleSignIn.signIn();
      expect(signInAccountSecondAttempt, isNotNull);
    },
  );
}

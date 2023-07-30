import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MockSignInWithApple extends Mock implements SignInWithApple {
  Future<bool> signIn() async {
    return super.noSuchMethod(
      Invocation.method(#signIn, []),
      returnValue: Future.value(true),
    );
  }
}

class MySignInWithApple {
  MySignInWithApple({required this.signInWithApple});

  final MockSignInWithApple signInWithApple;

  Future<bool> signIn() async {
    return await signInWithApple.signIn();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(
    () {
      SignInWithApple.channel.setMockMethodCallHandler(null);
    },
  );

  test(
    'Melakukan otorisasi menggunakan Apple ID',
    () async {
      SignInWithApple.channel.setMockMethodCallHandler(
        (methodCall) async {
          if (methodCall.method == 'performAuthorizationRequest') {
            return <dynamic, dynamic>{
              'type': 'appleid',
              'userIdentifier': 'userIdentifier',
              'givenName': 'Joko',
              'familyName': 'Wi',
              'email': 'user@email.com',
              'identityToken': 'identityToken',
              'authorizationCode': 'authorizationCode',
            };
          }

          throw Exception('Exception');
        },
      );

      expect(
        await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.example',
            redirectUri: Uri.parse('https://example.com'),
          ),
        ),
        isA<AuthorizationCredentialAppleID>(),
      );
    },
  );

  test(
    'Melakukan otorisasi menggunakan username dan password',
    () async {
      // ignore: deprecated_member_use
      SignInWithApple.channel.setMockMethodCallHandler(
        (methodCall) async {
          if (methodCall.method == 'performAuthorizationRequest') {
            return <dynamic, dynamic>{
              'type': 'password',
              'username': 'user',
              'password': 'admin',
            };
          }

          throw Exception('Exception');
        },
      );

      expect(
        await SignInWithApple.getKeychainCredential(),
        isA<AuthorizationCredentialPassword>(),
      );
    },
  );

  test(
    'Test Sign In dengan Apple - sukses',
    () async {
      final MockSignInWithApple mockSignInWithApple = MockSignInWithApple();

      when(mockSignInWithApple.signIn()).thenAnswer((_) async => true);

      final mySignInWithApple = MySignInWithApple(
        signInWithApple: mockSignInWithApple,
      );

      final result = await mySignInWithApple.signIn();
      expect(result, true);
    },
  );

  test(
    'Test Sign In dengan Apple - Gagal',
    () async {
      final MockSignInWithApple mockSignInWithApple = MockSignInWithApple();

      when(mockSignInWithApple.signIn()).thenAnswer((_) async => false);

      final yourSignInWithAppleClass = MySignInWithApple(
        signInWithApple: mockSignInWithApple,
      );

      final result = await yourSignInWithAppleClass.signIn();

      expect(result, false);
    },
  );
}

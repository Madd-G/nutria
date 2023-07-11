import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(8.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  const Text('Selamat Datang'),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.close)),
                ],
              ),
              content: SizedBox(
                width: 350.0,
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Silahkan masuk dengan akun anda'),
                    const SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthCubit>().signInWithApple(context).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Berhasil Login'),
                                ),
                              ),
                            );
                        Navigator.pop(dialogContext);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/apple-logo.png',
                                width: 25.0,
                                height: 25.0,
                              ),
                              const SizedBox(width: 10.0),
                              const Text(
                                'Sign in with Apple',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<AuthCubit>()
                            .signInWithGoogle(context)
                            .then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Berhasil Login'),
                                ),
                              ),
                            );
                        // (mounted) {
                        Navigator.pop(dialogContext);
                        // };
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                width: 27.0,
                                height: 27.0,
                              ),
                              const SizedBox(width: 7.0),
                              const Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        width: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        child: Icon(
          Icons.account_circle,
          size: (Responsive.isTablet(context)) ? 65 : 45.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

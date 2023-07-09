import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutria/ui/home_screen/widgets/login_dialog.dart';
import 'package:nutria/ui/home_screen/widgets/logout_dialog.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';

enum Menu { login, logout }

class WelcomeSection extends StatefulWidget {
  const WelcomeSection({super.key, required this.size});

  final Size size;

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    String? greeting;
    // final GlobalKey<PopupMenuButtonState> popUpKey = GlobalKey();
    // ignore: unused_local_variable
    String selectedMenu = '';
    int dt = DateTime.now().hour;
    if (dt < 10) {
      greeting = "SELAMAT PAGI";
    } else if (dt < 15) {
      greeting = "SELAMAT SIANG";
    } else if (dt < 18) {
      greeting = "SELAMAT SORE";
    } else {
      greeting = "SELAMAT MALAM";
    }

    String? month;

    switch (DateTime.now().month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "Februari";
        break;
      case 3:
        month = "Maret";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "Mei";
        break;
      case 6:
        month = "Juni";
        break;
      case 7:
        month = "Juli";
        break;
      case 8:
        month = "Agustus";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "Oktober";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "Desember";
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting 😀',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: (Responsive.isTablet(context)) ? 35 : 22,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                'Hari ini ${DateTime.now().day} $month ${DateTime.now().year}',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: (Responsive.isTablet(context)) ? 25 : 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: (Responsive.isTablet(context))
                    ? widget.size.height * 0.009
                    : widget.size.height * 0.005,
              ),
            ],
          ),
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.all(8.0),
                          title: const Text('Logout'),
                          content: SizedBox(
                            width: 300.0,
                            height: 80.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await googleSignIn.signOut();
                                    await FirebaseAuth.instance.signOut().then(
                                          (value) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                            const SnackBar(
                                              content: Text('Berhasil logout'),
                                            ),
                                          ),
                                        );
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          25.0, 8.0, 25.0, 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '  YA  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          25.0, 8.0, 25.0, 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'TIDAK',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
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
                    child: Center(
                      child: Text(
                        // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
                        FirebaseAuth.instance.currentUser!.email![0]
                            .toUpperCase(),
                        style: TextStyle(
                            fontSize:
                                (Responsive.isTablet(context)) ? 60 : 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              } else {
                // belum login
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.all(8.0),
                          title: const Text('Login'),
                          content: SizedBox(
                            width: 300.0,
                            height: 80.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithGoogle(context)
                                        .then(
                                          (value) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                            const SnackBar(
                                              content: Text('Berhasil Login'),
                                            ),
                                          ),
                                        );
                                    // (mounted) {
                                    Navigator.pop(context);
                                    // };
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25.0, 8.0, 25.0, 8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/google.png',
                                            width: 30.0,
                                            height: 30.0,
                                          ),
                                          const SizedBox(width: 10.0),
                                          const Text(
                                            'Google',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<AuthCubit>()
                                        .signInWithApple(context)
                                        .then(
                                          (value) =>
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                            const SnackBar(
                                              content: Text('Berhasil Login'),
                                            ),
                                          ),
                                        );
                                    // (mounted) {
                                    Navigator.pop(context);
                                    // };
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25.0, 8.0, 25.0, 8.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/apple-logo.png',
                                            width: 30.0,
                                            height: 30.0,
                                          ),
                                          const SizedBox(width: 10.0),
                                          const Text(
                                            'Apple',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
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
            },
          ),
        ],
      ),
    );
  }
}

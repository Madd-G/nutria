import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    final GlobalKey<PopupMenuButtonState> popUpKey = GlobalKey();
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

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$greeting 😀',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: (Responsive.isTablet(context)) ? 40 : 13,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${FirebaseAuth.instance.currentUser!.email?.split('@')[0].toUpperCase()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: (Responsive.isTablet(context)) ? 50 : 15,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: (Responsive.isTablet(context))
                          ? widget.size.height * 0.009
                          : widget.size.height * 0.005,
                    ),
                  ],
                );
              } else {
                return Text(
                  greeting!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: (Responsive.isTablet(context)) ? 53 : 20,
                      fontWeight: FontWeight.w700),
                );
              }
            },
          ),
          PopupMenuButton<Menu>(
            icon: Container(
              height: (Responsive.isTablet(context)) ? 65.0 : 50.0,
              width: (Responsive.isTablet(context)) ? 65.0 : 50.0,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    return Center(
                        child: Text(
                      FirebaseAuth.instance.currentUser!.email![0]
                          .toUpperCase(),
                      style: TextStyle(
                          fontSize: (Responsive.isTablet(context)) ? 65 : 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ));
                  } else {
                    return Center(
                      child: Icon(
                        Icons.account_circle,
                        size: (Responsive.isTablet(context)) ? 65 : 50.0,
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
            ),
            iconSize: (Responsive.isTablet(context)) ? 65 : 50,
            key: popUpKey,
            onSelected: (Menu item) async {
              setState(() {
                selectedMenu = item.name;
              });
              if (selectedMenu == 'login') {
                context.read<AuthCubit>().signInWithGoogle(context).then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berhasil Login'),
                        ),
                      ),
                    );
              } else {
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();
                (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Berhasil logout')),
                  );
                };
              }
            },
            itemBuilder: (BuildContext context) {
              if (FirebaseAuth.instance.currentUser?.uid == null) {
                return <PopupMenuEntry<Menu>>[
                  PopupMenuItem<Menu>(
                    value: Menu.login,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: (Responsive.isTablet(context)) ? 30 : 10),
                    ),
                  ),
                ];
              } else {
                return <PopupMenuEntry<Menu>>[
                  PopupMenuItem<Menu>(
                    value: Menu.logout,
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: (Responsive.isTablet(context)) ? 30 : 10),
                    ),
                  ),
                ];
              }
            },
          ),
        ],
      ),
    );
  }
}

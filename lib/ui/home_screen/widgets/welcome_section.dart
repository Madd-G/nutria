import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../blocs/blocs.dart';

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
    String _selectedMenu = '';
    int dt = DateTime.now().hour;
    if (dt < 10) {
      greeting = "SELAMAT PAGI";
    } else if (dt < 16) {
      greeting = "SELAMAT SIANG";
    } else if (dt < 19) {
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
                greeting,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                'Hari ini ${DateTime.now().day} $month ${DateTime.now().year}',
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: widget.size.height * 0.005,
              ),
            ],
          ),
          PopupMenuButton<Menu>(
              icon: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
              iconSize: 50.0,
              key: popUpKey,
              onSelected: (Menu item) {
                setState(() {
                  _selectedMenu = item.name;
                  // Navigator.pop(context);
                });
              },
              itemBuilder: (BuildContext context) {
                if (FirebaseAuth.instance.currentUser?.uid == null) {
                  return <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.login,
                      child: GestureDetector(
                        onTap: () async {
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
                        },
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ];
                } else {
                  return <PopupMenuEntry<Menu>>[
                    PopupMenuItem<Menu>(
                      value: Menu.logout,
                      child: GestureDetector(
                        onTap: () async {
                          await googleSignIn.signOut();
                          await FirebaseAuth.instance.signOut();
                          (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Berhasil logout')),
                            );
                          };
                        },
                        child: const Center(
                          child: Text(
                            'LogOut',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ];
                }
              }),
        ],
      ),
    );
  }
}

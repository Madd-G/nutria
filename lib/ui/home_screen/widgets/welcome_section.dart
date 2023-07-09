import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../responsive.dart';
import 'widgets.dart';

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
    String? greeting;
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
                return const LogoutDialog();
              } else {
                // belum login
                return const LoginDialog();
              }
            },
          ),
        ],
      ),
    );
  }
}



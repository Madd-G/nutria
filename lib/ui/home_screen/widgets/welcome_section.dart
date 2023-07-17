import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../responsive.dart';
import 'widgets.dart';

enum Menu { login, logout }

class WelcomeSection extends StatefulWidget {
  WelcomeSection({super.key, required this.size});

  final Size size;

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String? greeting;
    int dt = DateTime.now().hour;
    if (dt < 12) {
      greeting = "GOOD MORNING".tr;
    } else if (dt >= 12 && dt < 18) {
      greeting = "GOOD AFTERNOON,".tr;
    } else {
      greeting = "GOOD EVENING".tr;
    }

    String? month;

    switch (DateTime.now().month) {
      case 1:
        month = "January".tr;
        break;
      case 2:
        month = "February".tr;
        break;
      case 3:
        month = "March".tr;
        break;
      case 4:
        month = "April".tr;
        break;
      case 5:
        month = "May".tr;
        break;
      case 6:
        month = "June".tr;
        break;
      case 7:
        month = "July".tr;
        break;
      case 8:
        month = "August".tr;
        break;
      case 9:
        month = "September".tr;
        break;
      case 10:
        month = "October".tr;
        break;
      case 11:
        month = "November".tr;
        break;
      case 12:
        month = "December".tr;
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
                style: TextStyle(
                    // color: Colors.grey,
                    fontSize: (Responsive.isTablet(context)) ? 35 : 22,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                '${DateFormat('EEEE').format(DateTime.now()).tr}, ${DateTime.now().day} $month ${DateTime.now().year}',
                style: TextStyle(
                    // color: Colors.black,
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

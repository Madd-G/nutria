import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../../utils/dialogs/dialogs.dart';

class WelcomeSection extends StatelessWidget {
  WelcomeSection(
      {super.key, required this.size, required this.l10n, this.fakeHour});

  final Size size;
  final AppLocalizations l10n;
  int? fakeHour;

  @override
  Widget build(BuildContext context) {
    String? greeting;
    int dt = DateTime.now().hour;
    int s = 13;
    if (s! < 12) {
      greeting = l10n.goodMorning;
    } else if (s! >= 12 && s! < 18) {
      greeting = l10n.goodAfternoon;
    } else {
      greeting = l10n.goodEvening;
    }

    String? month;

    switch (DateTime.now().month) {
      case 1:
        month = l10n.january;
        break;
      case 2:
        month = l10n.february;
        break;
      case 3:
        month = l10n.march;
        break;
      case 4:
        month = l10n.april;
        break;
      case 5:
        month = l10n.may;
        break;
      case 6:
        month = l10n.june;
        break;
      case 7:
        month = l10n.july;
        break;
      case 8:
        month = l10n.august;
        break;
      case 9:
        month = l10n.september;
        break;
      case 10:
        month = l10n.october;
        break;
      case 11:
        month = l10n.november;
        break;
      case 12:
        month = l10n.december;
        break;
    }

    String? dayOfWeek;

    switch (DateFormat('EEEE').format(DateTime.now())) {
      case 'Monday':
        dayOfWeek = l10n.monday;
        break;
      case 'Tuesday':
        dayOfWeek = l10n.tuesday;
        break;
      case 'Wednesday':
        dayOfWeek = l10n.wednesday;
        break;
      case 'Thursday':
        dayOfWeek = l10n.thursday;
        break;
      case 'Friday':
        dayOfWeek = l10n.friday;
        break;
      case 'Saturday':
        dayOfWeek = l10n.saturday;
        break;
      case 'Sunday':
        dayOfWeek = l10n.sunday;
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
                key: const Key('greeting_text'),
                style: TextStyle(
                    // color: Theme.of(context).brightness == Brightness.dark
                    //     ? Colors.white
                    //     : Colors.black,
                    fontSize: (Responsive.isMobile(context)) ? 22.0 : 35.0,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                // '$dayOfWeek, ${DateTime.now().day} $month ${DateTime.now().year}',
                'Kamis, 27 Juli 2023',
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: (Responsive.isMobile(context)) ? 16.0 : 25.0,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: (Responsive.isMobile(context))
                    ? size.height * 0.005
                    : size.height * 0.009,
              ),
            ],
          ),
          // StreamBuilder<User?>(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasData) {
          //       return const LogoutDialog(
          //         key: Key('logout-dialog'),
          //       );
          //     } else {
          //       return const LoginDialog(
          //         key: Key('login-dialog'),
          //         // l10n: widget.l10n,
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

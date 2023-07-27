import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import '../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../responsive.dart';
import '../ui/chat_screen/screen/chat_screen.dart';

class NutriAIButton extends StatelessWidget {
  const NutriAIButton({super.key, required this.mainWidget, this.screenHeight});

  final Widget mainWidget;
  final double? screenHeight;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    (Platform.isIOS || Platform.isMacOS) ? 250.0 : 210.0;
    return FloatingDraggableWidget(
      mainScreenWidget: mainWidget,
      screenHeight: screenHeight,
      floatingWidget: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return FloatingActionButton(
            key: const Key('fab-key'),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            tooltip: l10n.nutriAIGreeting,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(l10n: l10n),
                  // builder: (context) => const MockChatScreen(),
                ),
              );
            },
            child: Padding(
              padding:
                  EdgeInsets.all(Responsive.isMobile(context) ? 10.0 : 15.0),
              child: Image.asset(
                'assets/images/chatbot.png',
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          );
        },
      ),
      floatingWidgetWidth: Responsive.isMobile(context) ? 55.0 : 70.0,
      floatingWidgetHeight: Responsive.isMobile(context) ? 55.0 : 70.0,
    );
  }
}

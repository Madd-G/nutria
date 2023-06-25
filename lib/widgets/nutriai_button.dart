import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import '../ui/chat_screen/screen/chat_screen.dart';

class NutriAIButton extends StatelessWidget {
  const NutriAIButton({
    super.key,
    required this.mainWidget,
  });

  final Widget mainWidget;

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      mainScreenWidget: mainWidget,
      screenHeight: MediaQuery.of(context).size.height * 0.95,
      floatingWidget: FloatingActionButton(
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
          tooltip: 'Hello, may I help you?',
          onPressed: () {
            if (FirebaseAuth.instance.currentUser?.uid == null) {
              context.read<AuthCubit>().signInWithGoogle(context);
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/AI.png',
            ),
          )),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}
